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

      -- Enable syntax highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      -- Enable incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",    -- Start selection
          node_incremental = "grn",  -- Expand selection
          scope_incremental = "grc", -- Expand scope
          node_decremental = "grm",  -- Shrink selection
        },
      },

      -- Enable indentation
      indent = { enable = true },

      -- Enable folding with Tree-sitter
      fold = {
        enable = true
      }
    })
  end,
  build = ":TSUpdate"
}
