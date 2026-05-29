return {
	{
		'stevearc/conform.nvim',
		event = { 'BufWritePre' },
		cmd = { 'ConformInfo' },
		opts = {
			formatters_by_ft = {
				lua = { 'stylua' },
				c = { 'clang-format' },
				cpp = { 'clang-format' },
				python = { 'black' },
				javascript = { 'prettier' },
				typescript = { 'prettier' },
				javascriptreact = { 'prettier' },
				typescriptreact = { 'prettier' },
				json = { 'prettier' },
				html = { 'prettier' },
				css = { 'prettier' },
				markdown = { 'prettier' },
				sh = { 'shfmt' },
			},
			format_on_save = function(bufnr)
				if not vim.g.autoformat_enabled then
					return
				end
				return { timeout_ms = 500, lsp_format = 'fallback' }
			end,
		},
		init = function()
			if vim.g.autoformat_enabled == nil then
				vim.g.autoformat_enabled = true
			end
		end,
	},
}
