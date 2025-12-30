return {
    "nvim-mini/mini.nvim",
    version = false,
    lazy = false,
    config = function()
        require("mini.map").setup({
            integrations = {
                -- search results (/ ? n N)
                require("mini.map").gen_integration.builtin_search(),

                -- LSP diagnostics (errors, warnings, hints)
                require("mini.map").gen_integration.diagnostic(),

                -- Git changes (added / changed / deleted)
                require("mini.map").gen_integration.gitsigns(),
            },

            symbols = {
                -- nice readable blocks instead of dots
                encode = require("mini.map").gen_encode_symbols.dot("4x2"),
            },

            window = {
                side = "right",
                width = 10,
                winblend = 25,
                show_integration_count = false,
            },
        })

        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                MiniMap.open()
            end,
        })
    end,
}
