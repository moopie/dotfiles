return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "gopls",
                "rust_analyzer",
                "clangd",
                "zls",
                "jdtls",
                "ts_ls",
                "eslint",
                "tailwindcss",
                "html",
                "cssls",
                "emmet_language_server",
                "bashls",
            },
        })

        local servers = {
            gopls = {
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                    },
                },
            },
            rust_analyzer = {
                settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true },
                        checkOnSave = { command = "clippy" },
                    },
                },
            },
            clangd = {},
            zls = {},
            jdtls = {},
            ts_ls = {},
            eslint = {},
            tailwindcss = {},
            html = {},
            cssls = {},
            emmet_language_server = {
                filetypes = {
                    "html",
                    "css",
                    "scss",
                    "javascriptreact",
                    "typescriptreact",
                    "vue",
                    "svelte",
                },
            },
            bashls = {},
            csharp_ls = {
                cmd = { "csharp-ls" },
            },
            hls = {
                cmd = { "haskell-language-server-wrapper", "--lsp" },
            },
        }

        for name, opts in pairs(servers) do
            opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})
            vim.lsp.config(name, opts)
            vim.lsp.enable(name)
        end
    end,
}
