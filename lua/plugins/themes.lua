return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {
					{
						name = "Tokyo Night",
						colorscheme = "tokyonight",
					},
					{
						name = "Tokyo Night Night",
						colorscheme = "tokyonight-night",
					},
					{
						name = "Tokyo Night Storm",
						colorscheme = "tokyonight-storm",
					},
					{
						name = "Tokyo Night Day",
						colorscheme = "tokyonight-day",
					},
					{
						name = "Tokyo Night Moon",
						colorscheme = "tokyonight-moon",
					},
				},
				livePreview = true,
			})
		end
	},
}
