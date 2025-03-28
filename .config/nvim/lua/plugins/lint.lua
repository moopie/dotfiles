return {
  'mfussenegger/nvim-lint',
  config = function()
    require('lint').linters_by_ft = {
      go         = { "golangci-lint" },
      python     = { "flake8" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
    }
  end
}