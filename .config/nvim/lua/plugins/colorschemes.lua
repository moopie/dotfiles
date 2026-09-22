return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin-frappe")
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
    },
    { "folke/tokyonight.nvim", name = "tokyonight" },
    { "rose-pine/neovim", name = "rose-pine" },
    { "rebelot/kanagawa.nvim", name = "kanagawa" },
    { "sainnhe/everforest", name = "everforest" },
}
