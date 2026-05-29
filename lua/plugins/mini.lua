return {
	{
		'nvim-mini/mini.ai',
		version = '*',
		config = function()
			local ai = require('mini.ai')
			ai.setup({
				custom_textobjects = {
					f = ai.gen_spec.treesitter({ a = '@function.outer',    i = '@function.inner' }),
					c = ai.gen_spec.treesitter({ a = '@class.outer',       i = '@class.inner' }),
					l = ai.gen_spec.treesitter({ a = '@loop.outer',        i = '@loop.inner' }),
					o = ai.gen_spec.treesitter({ a = '@conditional.outer', i = '@conditional.inner' }),
				},
			})
		end,
	},
	{ 'nvim-mini/mini.cmdline', version = '*', opts = {} },
	{
		'nvim-mini/mini.cursorword',
		version = '*',
		config = function()
			require('mini.cursorword').setup()
			local function set_hl()
				vim.api.nvim_set_hl(0, 'MiniCursorword',        { underline = true })
				vim.api.nvim_set_hl(0, 'MiniCursorwordCurrent', { underline = true })
			end
			set_hl()
			vim.api.nvim_create_autocmd('ColorScheme', { callback = set_hl })
		end,
	},
	{ 'nvim-mini/mini.surround', version = '*', opts = {} },
	{ 'nvim-mini/mini.animate', version = '*', opts = {} },
	{ 'nvim-mini/mini.move', version = '*', opts = {} },
}
