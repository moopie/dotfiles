return {
  'stevearc/conform.nvim',
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        go         = { "goimports" },
        cs         = { "csharpier" },
        css        = { "prettier" },
        json       = { "prettier" },
        html       = { "prettier" },
        python     = { "black", "isort" },
        javascript = { "prettier" },
        typescript = { "prettier" },
      },
      format_on_save = {
        timeout_ms   = 500,
        lsp_fallback = true,
      }
    })
  end
}