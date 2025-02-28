return {
  -- LSP Config
  'neovim/nvim-lspconfig',

  -- LSP Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',     -- LSP Completion
      'hrsh7th/cmp-buffer',       -- Buffer completions
      'hrsh7th/cmp-path',         -- Path completions
      'saadparwaiz1/cmp_luasnip', -- Snippet completions
      'L3MON4D3/LuaSnip'          -- Snippet Engine
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- LSP Formatting (autoformat on save)
  {
    'stevearc/conform.nvim',
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          go = { "goimports" },
          cs = { "csharpier" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          json = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          python = { "black", "isort" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      })
    end
  },

  -- Linter
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        go = { "golangci-lint" },
        python = { "flake8" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
      }
    end
  },

  -- Debugging (DAP for Go)
  {
    'mfussenegger/nvim-dap',
    dependencies = { 'leoluz/nvim-dap-go' },
    config = function()
      require('dap-go').setup()
    end
  },
}
