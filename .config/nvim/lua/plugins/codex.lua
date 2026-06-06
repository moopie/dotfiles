return {
  "johnseth97/codex.nvim",
  keys = {
    {
      "<leader>c",
      function()
        require("codex").toggle()
      end,
      desc = "Codex: Toggle",
      mode = { "n", "t" },
    },
    {
      "<leader>c",
      function()
        local register = vim.fn.getreg('"')
        local register_type = vim.fn.getregtype('"')
        local z_register = vim.fn.getreg("z")
        local z_register_type = vim.fn.getregtype("z")
        local filetype = vim.bo.filetype

        vim.cmd('normal! "zy')
        local selection = vim.fn.getreg("z")
        vim.fn.setreg('"', register, register_type)
        vim.fn.setreg("z", z_register, z_register_type)

        if selection == "" then
          vim.notify("No visual selection to explain", vim.log.levels.WARN)
          return
        end

        require("codex").open()

        vim.schedule(function()
          local state = require("codex.state")
          if not state.job then
            vim.notify("Codex terminal is not ready", vim.log.levels.WARN)
            return
          end

          local prompt = table.concat({
            "Explain this selection.",
            "",
            "```" .. filetype,
            selection,
            "```",
          }, "\n")

          vim.fn.chansend(state.job, "\027[200~" .. prompt .. "\027[201~\r")
        end)
      end,
      desc = "Codex: Explain selection",
      mode = "v",
    },
  },
  opts = {
    keymaps = {
      toggle = nil,
      quit = "<C-q>",
    },
    border = "rounded",
    width = 0.8,
    height = 0.8,
    model = nil,
    autoinstall = false,
    panel = false,
    use_buffer = false,
  },
}
