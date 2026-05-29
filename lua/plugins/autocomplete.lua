return {
	{
		"folke/which-key.nvim"
	},
	{
		'saghen/blink.cmp',
		dependencies = {
			'saghen/blink.lib',
			'rafamadriz/friendly-snippets',
		},
		build = function()
			require('blink.cmp').build():wait(60000)
		end,

		opts = {
			keymap = {
				preset = 'default',
				['<CR>'] = { 'select_and_accept', 'fallback' },
			},

			completion = { documentation = { auto_show = false } },
			sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
			fuzzy = { implementation = "rust" }
		},
	},
}
