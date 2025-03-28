return {
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
}