return {
  "https://github.com/github/copilot.vim",
  build = function()
    vim.cmd("Copilot setup")
  end,
  opts = {},
}
