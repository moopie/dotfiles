return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("gruvbox")
		end,
	},
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "folke/tokyonight.nvim", name = "tokyonight" },
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "rebelot/kanagawa.nvim", name = "kanagawa" },
	{ "sainnhe/everforest", name = "everforest" },
}
