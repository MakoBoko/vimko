return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"ts_ls",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-org/mason-lspconfig.nvim" },
		config = function()
			-- nvim-lspconfig provides default cmd/filetypes/root_dir for each server.
			-- vim.lsp.enable() is the 0.11+ native way to activate them.
			vim.lsp.enable({ "lua_ls", "ts_ls", "racket_langserver" })
		end,
	},
}
