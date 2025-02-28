return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    local config = require("nvim-treesitter.configs")

    config.setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "elixir",
        "heex",
        "javascript",
        "html",
        "c_sharp",
        "go",
        "python"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
  build = ":TSUpdate"
}
