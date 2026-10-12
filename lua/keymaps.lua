local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')
map({ 'v', 'n', 'x' }, '<leader>y', '"+y')
map({ 'v', 'n', 'x' }, '<leader>d', '"+d')

map('n', '<leader>e', ":Yazi<CR>", opts)
map("n", "<leader>lg", ":LazyGit<CR>", opts)

map('n', '<leader> ', Snacks.picker.smart, opts)
map('n', '<leader>b', Snacks.picker.buffers, opts)
map('n', '<leader>f', Snacks.picker.files, opts)
map('n', '<leader>r', Snacks.picker.recent, opts)
map('n', '<leader>g', Snacks.picker.git_files, opts)
map('n', '<leader>s', Snacks.picker.lsp_workspace_symbols, opts)

map('n', '<leader>:', Snacks.picker.commands, opts)
map('n', '<leader>/', Snacks.picker.grep, opts)

map("n", "<leader>lD", vim.diagnostic.open_float, opts)
map("n", "<leader>ln", vim.diagnostic.goto_next, opts)
map("n", "<leader>lp", vim.diagnostic.goto_prev, opts)
map("n", "<leader>lh", vim.lsp.buf.hover, opts)
map("n", "<leader>ld", vim.lsp.buf.type_definition, opts)
map("n", "<leader>lr", vim.lsp.buf.rename, opts)
map("n", "<leader>lf", vim.lsp.buf.format, opts)
map({ "n", "i" }, "<C-_>", function() vim.lsp.buf.code_action() end, opts)
map('i', '<C-Space>', function() vim.lsp.completion.get() end)

local tab_completion = function()
	if vim.fn.pumvisible() == 1 then
		return "<C-y>"
	elseif require("copilot.suggestion").is_visible() then
		return require("copilot.suggestion").accept()
	else
		return "<Tab>"
	end
end
map('i', '<Tab>', tab_completion, { expr = true, noremap = true })

map('i', '<C-j>', function()
	return vim.fn.pumvisible() == 1 and '<C-n>' or '<C-j>'
end, { expr = true, noremap = true })
map('i', '<C-k>', function()
	return vim.fn.pumvisible() == 1 and '<C-p>' or '<C-k>'
end, { expr = true, noremap = true })


-- smart-splits: move between nvim splits and tmux panes
map('n', "<c-h>", function() require('smart-splits').move_cursor_left() end, opts)
map('n', "<c-j>", function() require('smart-splits').move_cursor_down() end, opts)
map('n', "<c-k>", function() require('smart-splits').move_cursor_up() end, opts)
map('n', "<c-l>", function() require('smart-splits').move_cursor_right() end, opts)


-- opencode
vim.keymap.set('n', '<leader>ot', function() require('opencode').toggle() end, { desc = 'Toggle opencode' })
vim.keymap.set('n', '<leader>oA', function() require('opencode').ask() end, { desc = 'Ask opencode' })
vim.keymap.set('n', '<leader>oa', function() require('opencode').ask('@cursor: ') end,
	{ desc = 'Ask opencode about this' })
vim.keymap.set('v', '<leader>oa', function() require('opencode').ask('@selection: ') end,
	{ desc = 'Ask opencode about selection' })
vim.keymap.set({ 'n', 'v' }, '<leader>os', function() require('opencode').select() end,
	{ desc = 'Select opencode prompt' })
vim.keymap.set('n', '<leader>on', function() require('opencode').command('session_new') end,
	{ desc = 'New opencode session' })
vim.keymap.set('n', '<leader>oy', function() require('opencode').command('messages_copy') end,
	{ desc = 'Copy last opencode response' })
vim.keymap.set('n', '<S-C-u>', function() require('opencode').command('messages_half_page_up') end,
	{ desc = 'Messages half page up' })
vim.keymap.set('n', '<S-C-d>', function() require('opencode').command('messages_half_page_down') end,
	{ desc = 'Messages half page down' })

