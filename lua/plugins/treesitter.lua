return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			folds = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
				"racket",
				"cpp",
				"go",
			},
		},
		config = function(_, opts)
			local TS = require("nvim-treesitter")
			local tsconfig = require("nvim-treesitter.config")

			-- install missing parsers (mirrors LazyVim's ensure_installed logic)
			local installed = tsconfig.get_installed()
			local to_install = vim.tbl_filter(function(lang)
				return not vim.list_contains(installed, lang)
			end, opts.ensure_installed or {})
			if #to_install > 0 then
				TS.install(to_install)
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_config", { clear = true }),
				callback = function(ev)
					local ft = ev.match
					local lang = vim.treesitter.language.get_lang(ft) or ft

					local function feat_enabled(feat)
						local f = opts[feat] or {}
						return f.enable ~= false
							and not (type(f.disable) == "table" and vim.tbl_contains(f.disable, lang))
					end

					local function has_query(query)
						local ok, result = pcall(vim.treesitter.query.get, lang, query)
						return ok and result ~= nil
					end

					-- highlighting
					if feat_enabled("highlight") and has_query("highlights") then
						pcall(vim.treesitter.start, ev.buf)
					end

					-- indents
					if feat_enabled("indent") and has_query("indents") then
						vim.opt_local.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end

					-- folds
					if feat_enabled("folds") and has_query("folds") then
						vim.opt_local.foldmethod = "expr"
						vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.opt_local.foldlevel = 99
					end
				end,
			})
		end,
	}
}
