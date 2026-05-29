return {
	{
		'rcarriga/nvim-notify',
		enabled = true,
		opts = {},
		config = function(_, opts)
			local notify = require('notify')
			notify.setup(opts)
			vim.notify = notify
		end,
	},
	{
		'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons', opts = {}
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {}
	}
}
