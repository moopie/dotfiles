return {
	"nvim-treesitter/nvim-treesitter-context",
	lazy = false,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesitter-context").setup({
			enable = true,
			max_lines = 5, -- how many context lines to show
			trim_scope = "outer",
			mode = "cursor", -- cursor | top
			separator = nil, -- or a string like "─"
		})
	end,
}
