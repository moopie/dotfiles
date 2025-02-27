return {
  -- LSP Config
  'neovim/nvim-lspconfig',

  -- LSP Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- LSP Completion
      'hrsh7th/cmp-buffer', -- Buffer completions
      'hrsh7th/cmp-path', -- Path completions
      'saadparwaiz1/cmp_luasnip', -- Snippet completions
      'L3MON4D3/LuaSnip' -- Snippet Engine
    }
  },

  -- LSP Formatting (autoformat on save)
  {
    'stevearc/conform.nvim',
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          go = { "goimports" },
          cs = { "csharpier" }
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      })
    end
  }
}
