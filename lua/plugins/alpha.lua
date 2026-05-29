return {
	{
		'goolord/alpha-nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			local alpha = require('alpha')
			local dashboard = require('alpha.themes.dashboard')

			dashboard.section.header.val = {
				[[                               ___           ___           ___     ]],
				[[      ___        ___          /__/\         /__/|         /  /\    ]],
				[[     /__/\      /  /\        |  |::\       |  |:|        /  /::\   ]],
				[[     \  \:\    /  /:/        |  |:|:\      |  |:|       /  /:/\:\  ]],
				[[      \  \:\  /__/::\      __|__|:|\:\   __|  |:|      /  /:/  \:\ ]],
				[[  ___  \__\:\ \__\/\:\__  /__/::::| \:\ /__/\_|:|____ /__/:/ \__\:\]],
				[[ /__/\ |  |:|    \  \:\/\ \  \:\~~\__\/ \  \:\/:::::/ \  \:\ /  /:/]],
				[[ \  \:\|  |:|     \__\::/  \  \:\        \  \::/~~~~   \  \:\  /:/ ]],
				[[  \  \:\__|:|     /__/:/    \  \:\        \  \:\        \  \:\/:/  ]],
				[[   \__\::::/      \__\/      \  \:\        \  \:\        \  \::/   ]],
				[[       ~~~~                   \__\/         \__\/         \__\/    ]],
				'',
			}
			dashboard.section.header.opts.hl = 'AlphaHeader'

			dashboard.section.buttons.val = {
				dashboard.button('f', '󰱽  Find File',       ':Telescope find_files<CR>'),
				dashboard.button('r', '󰋚  Recent Files',    ':Telescope oldfiles<CR>'),
				dashboard.button('w', '󰊄  Find Word',       ':Telescope live_grep<CR>'),
				dashboard.button('s', '󰦛  Restore Session', ':SessionRestore<CR>'),
				dashboard.button('e', '󰈔  New File',        ':ene <BAR> startinsert<CR>'),
				dashboard.button('l', '󰒲  Lazy',            ':Lazy<CR>'),
				dashboard.button('q', '󰅚  Quit',            ':qa<CR>'),
			}

			-- Placeholder while the joke loads
			dashboard.section.footer.val = { '', '  🤡 Loading your daily dose of cringe...', '' }
			dashboard.section.footer.opts.hl = 'AlphaFooter'

			alpha.setup(dashboard.config)

			-- Fetch a random dad joke from icanhazdadjoke.com
			vim.fn.jobstart(
				{ 'curl', '-s', '--max-time', '5', 'https://icanhazdadjoke.com/', '-H', 'Accept: text/plain' },
				{
					stdout_buffered = true,
					on_stdout = function(_, data)
						if not data then return end
						local joke = vim.trim(table.concat(data, ' '))
						if joke == '' then return end

						-- Wrap at ~64 chars
						local wrapped = {}
						local line = '  '
						for word in joke:gmatch('%S+') do
							if #line + #word + 1 > 66 then
								table.insert(wrapped, line)
								line = '  ' .. word
							else
								line = (line == '  ') and (line .. word) or (line .. ' ' .. word)
							end
						end
						if line ~= '  ' then table.insert(wrapped, line) end

						local footer = { '' }
						vim.list_extend(footer, wrapped)
						table.insert(footer, '')

						dashboard.section.footer.val = footer
						pcall(function()
							if vim.bo.filetype == 'alpha' then
								require('alpha').redraw()
							end
						end)
					end,
					on_stderr = function(_, data)
						-- Fallback joke if curl fails
						if data and data[1] and data[1] ~= '' then
							dashboard.section.footer.val = {
								'',
								"  Why do programmers prefer dark mode? Because light attracts bugs!",
								'',
							}
							pcall(function()
								if vim.bo.filetype == 'alpha' then require('alpha').redraw() end
							end)
						end
					end,
				}
			)
		end,
	}
}
