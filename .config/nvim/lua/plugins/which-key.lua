return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern",
        delay = 300,
        icons = {
            mappings = true,
        },
        spec = {
            { "<leader>f", group = "find" },
            { "<leader>l", group = "lsp" },
            { "<leader>t", group = "test" },
        },
    },
}
