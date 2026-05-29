-- Primeagen keymap for preserving the paste buffer
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = 'Paste - Preserve Paste Buffer'})

-- Windows
vim.keymap.set('n', '<leader>|', '<cmd>vsplit<CR>', { desc = 'Split vertical' })
vim.keymap.set('n', '<leader>-', '<cmd>split<CR>',  { desc = 'Split horizontal' })
vim.keymap.set('n', '<C-S-Up>',    '<cmd>resize +2<CR>',          { desc = 'Increase window height' })
vim.keymap.set('n', '<C-S-Down>',  '<cmd>resize -2<CR>',          { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-S-Left>',  '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-S-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Plugin UIs
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<CR>',  { desc = 'Open Lazy' })
vim.keymap.set('n', '<leader>m', '<cmd>Mason<CR>', { desc = 'Open Mason' })

-- Clear search highlights on Escape
vim.keymap.set('n', '<Esc>', function()
	vim.cmd('nohlsearch')
	vim.fn.setreg('/', '')
end)

-- Oil file explorer
vim.keymap.set('n', '<leader>e', function()
	local oil = require('oil')
	if vim.bo.filetype == 'oil' then
		oil.close()
	else
		oil.open()
	end
end, { desc = 'Toggle oil' })

-- Telescope 
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
 
-- Themery
vim.keymap.set('n', '<leader>th', vim.cmd.Themery, { desc = 'Themery' })

-- Bufferline
vim.keymap.set('n', 'H', '<cmd>BufferLineCyclePrev<CR>',    { desc = 'Previous buffer' })
vim.keymap.set('n', 'L', '<cmd>BufferLineCycleNext<CR>',    { desc = 'Next buffer' })
vim.keymap.set('n', '<C-S-h>', '<cmd>BufferLineMovePrev<CR>', { desc = 'Move buffer left' })
vim.keymap.set('n', '<C-S-l>', '<cmd>BufferLineMoveNext<CR>', { desc = 'Move buffer right' })
vim.keymap.set('n', '<leader>bd', function()
	if vim.bo.modified then
		local choice = vim.fn.confirm('Buffer has unsaved changes. Delete anyway?', '&Yes\n&No', 2)
		if choice == 1 then
			vim.cmd('bdelete!')
		end
	else
		vim.cmd('bdelete')
	end
end, { desc = 'Delete buffer' })
local function close_buffers(direction)
	local current = vim.api.nvim_get_current_buf()
	local elements = require('bufferline').get_elements().elements
	local current_pos = nil
	for i, el in ipairs(elements) do
		if el.id == current then current_pos = i; break end
	end
	if not current_pos then return end
	local has_modified = false
	for i, el in ipairs(elements) do
		local in_range = direction == 'left' and i < current_pos or i > current_pos
		if in_range and vim.bo[el.id].modified then has_modified = true; break end
	end
	if has_modified then
		local choice = vim.fn.confirm('Some buffers have unsaved changes. Close anyway?', '&Yes\n&No', 2)
		if choice ~= 1 then return end
	end
	local cmd = direction == 'left' and 'BufferLineCloseLeft' or 'BufferLineCloseRight'
	vim.cmd(cmd .. '!')
end

vim.keymap.set('n', '<leader>bl', function() close_buffers('left') end,  { desc = 'Delete all left buffers' })
vim.keymap.set('n', '<leader>br', function() close_buffers('right') end, { desc = 'Delete all right buffers' })

-- LSP (keymaps only active when an LSP is attached to the buffer)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local function opts(desc) return { buffer = ev.buf, desc = desc } end
		vim.keymap.set("n", "gd",         vim.lsp.buf.definition,   opts("Go to definition"))
		vim.keymap.set("n", "K",          vim.lsp.buf.hover,         opts("Hover docs"))
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,        opts("Rename symbol"))
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,   opts("Code action"))
		vim.keymap.set("n", "gr",         vim.lsp.buf.references,    opts("Go to references"))
		vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 })  end, opts("Next diagnostic"))
		vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts("Prev diagnostic"))
		vim.keymap.set("n", "]e", function() vim.diagnostic.jump({ count = 1,  severity = vim.diagnostic.severity.ERROR }) end, opts("Next error"))
		vim.keymap.set("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, opts("Prev error"))
		vim.keymap.set("n", "]w", function() vim.diagnostic.jump({ count = 1,  severity = vim.diagnostic.severity.WARN })  end, opts("Next warning"))
		vim.keymap.set("n", "[w", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })  end, opts("Prev warning"))
	end,
})

-- Conform (format on save toggle)
vim.keymap.set('n', '<leader>uf', function()
	vim.g.autoformat_enabled = not vim.g.autoformat_enabled
	vim.notify('Autoformat on save: ' .. (vim.g.autoformat_enabled and 'ON' or 'OFF'))
end, { desc = 'Toggle autoformat on save' })

-- Todo comments
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end,                                                          { desc = "Next todo" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end,                                                          { desc = "Prev todo" })
vim.keymap.set("n", "]f", function() require("todo-comments").jump_next({ keywords = { "FIX", "FIXME", "BUG", "ISSUE" } }) end,         { desc = "Next fixme/bug" })
vim.keymap.set("n", "[f", function() require("todo-comments").jump_prev({ keywords = { "FIX", "FIXME", "BUG", "ISSUE" } }) end,         { desc = "Prev fixme/bug" })
vim.keymap.set("n", "]n", function() require("todo-comments").jump_next({ keywords = { "NOTE", "INFO", "HINT" } }) end,                 { desc = "Next note" })
vim.keymap.set("n", "[n", function() require("todo-comments").jump_prev({ keywords = { "NOTE", "INFO", "HINT" } }) end,                 { desc = "Prev note" })
