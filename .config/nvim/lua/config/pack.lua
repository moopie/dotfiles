local plug_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "core", "opt")

local function list_plugin_files()
  local files = {}

  for name, type in vim.fs.dir(vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "plugins")) do
    if type == "file" and name:sub(-4) == ".lua" then
      files[#files + 1] = name:sub(1, -5)
    end
  end

  table.sort(files)
  return files
end

local function as_list(value)
  if value == nil then
    return {}
  end

  if type(value) ~= "table" then
    return { value }
  end

  if vim.islist(value) then
    return value
  end

  return { value }
end

local function normalize_spec(spec)
  if type(spec) == "string" then
    spec = { spec }
  end

  if spec[1] ~= nil and spec.src == nil then
    spec.src = spec[1]
    spec[1] = nil
  end

  if
    type(spec.src) == "string"
    and spec.src:match("^[%w_.-]+/[%w_.-]+$")
  then
    spec.src = "https://github.com/" .. spec.src
  end

  if spec.tag ~= nil and spec.version == nil then
    spec.version = spec.tag
  end

  return spec
end

local function infer_main(spec)
  if spec.main then
    return spec.main
  end

  local repo = vim.fn.fnamemodify(spec.src, ":t")
  repo = repo:gsub("%.git$", "")

  if repo == "nvim-treesitter" then
    return "nvim-treesitter.configs"
  end

  repo = repo:gsub("^nvim%-", "")
  repo = repo:gsub("%.nvim$", "")

  return repo
end

local specs_by_name = {}
local ordered_specs = {}

local function register_spec(spec)
  spec = normalize_spec(vim.deepcopy(spec))

  if not spec.src then
    return
  end

  local name = spec.name or vim.fn.fnamemodify(spec.src, ":t:r")
  spec.name = name

  if specs_by_name[name] then
    return
  end

  ordered_specs[#ordered_specs + 1] = spec
  specs_by_name[name] = spec

  for _, dep in ipairs(as_list(spec.dependencies)) do
    register_spec(dep)
  end
end

for _, module_name in ipairs(list_plugin_files()) do
  local exported = require("plugins." .. module_name)

  for _, spec in ipairs(as_list(exported)) do
    register_spec(spec)
  end
end

table.sort(ordered_specs, function(a, b)
  return (a.priority or 0) > (b.priority or 0)
end)

local function run_build(spec)
  if not spec.build then
    return
  end

  local path = vim.fs.joinpath(plug_dir, spec.name)

  if type(spec.build) == "function" then
    spec.build(spec)
    return
  end

  if type(spec.build) == "string" and spec.build:sub(1, 1) == ":" then
    vim.cmd.packadd(spec.name)
    vim.cmd(spec.build:sub(2))
    return
  end

  if type(spec.build) == "string" then
    vim.system(vim.split(spec.build, " ", { trimempty = true }), { cwd = path }):wait()
  end
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local spec = specs_by_name[ev.data.spec.name]
    if not spec or not (ev.data.kind == "install" or ev.data.kind == "update") then
      return
    end

    run_build(spec)
  end,
})

vim.pack.add(vim.tbl_map(function(spec)
  return {
    src = spec.src,
    name = spec.name,
    version = spec.version,
  }
end, ordered_specs))

local loaded = {}

local function load_plugin(name)
  if loaded[name] then
    return
  end

  local spec = specs_by_name[name]
  if not spec then
    return
  end

  for _, dep in ipairs(as_list(spec.dependencies)) do
    dep = normalize_spec(dep)
    load_plugin(dep.name or vim.fn.fnamemodify(dep.src, ":t:r"))
  end

  vim.cmd.packadd(spec.name)
  loaded[name] = true

  if spec.opts ~= nil then
    local opts = type(spec.opts) == "function" and spec.opts() or spec.opts

    if spec.main then
      require(spec.main).setup(opts)
    elseif type(spec.config) == "function" then
      spec.config(spec, opts)
    else
      require(infer_main(spec)).setup(opts)
    end
  end

  if spec.opts == nil and type(spec.config) == "function" then
    spec.config(spec)
  end

  for _, key in ipairs(as_list(spec.keys)) do
    local lhs = key[1]
    local rhs = key[2]
    local mode = key.mode or "n"
    local opts = { desc = key.desc, silent = key.silent ~= false, noremap = key.remap ~= true }
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

for _, spec in ipairs(ordered_specs) do
  load_plugin(spec.name)
end

local function tiny_packupdate()
  local ok, mod = pcall(require, "tiny-packupdate")
  if ok and type(mod) == "table" then
    if type(mod.update) == "function" then
      return mod.update()
    end

    if type(mod.pack_update) == "function" then
      return mod.pack_update()
    end
  end

  if vim.fn.exists(":TinyPackUpdate") == 2 then
    return vim.cmd.TinyPackUpdate()
  end

  if vim.fn.exists(":TinyUpdate") == 2 then
    return vim.cmd.TinyUpdate()
  end

  vim.pack.update()
end

vim.api.nvim_create_user_command("PackUpdate", function()
  tiny_packupdate()
end, { desc = "Update plugins managed by vim.pack" })
