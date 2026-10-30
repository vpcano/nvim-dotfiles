local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

-- multicursors
local clear_mcursors = '<Cmd>nohlsearch<Bar>diffupdate'
	.. '<Bar>call nvim_buf_clear_namespace(0, nvim_create_namespace("nvim.multicursor"), 0, -1)'
	.. '<Bar>normal! <C-L><CR>'
map('n', '<leader>mc', clear_mcursors, { desc = 'Clear multicursors + search hl + redraw' })
map('n', 'zQ', clear_mcursors, { desc = 'Clear multicursors + search hl + redraw' })
map('n', '<Esc>', clear_mcursors, { desc = 'Clear multicursors + search hl + redraw' })

map({ 'n', 'x' }, 'gl', function()
	vim.api.nvim_input(vim.api.nvim_replace_termcodes('<Esc>1Q*:nohlsearch<CR>zv1q=viw', true, false, true))
end, vim.tbl_extend('keep', { desc = 'Multicursor: select word, add cursor at next occurrence' }, opts))
map({ 'n', 'x' }, 'gL', function()
	vim.api.nvim_input(vim.api.nvim_replace_termcodes('<Esc>1Q#:nohlsearch<CR>zv1q=viw', true, false, true))
end, vim.tbl_extend('keep', { desc = 'Multicursor: select word, add cursor at previous occurrence' }, opts))

map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')
map({ 'v', 'n', 'x' }, '<leader>y', '"+y')
map({ 'v', 'n', 'x' }, '<leader>d', '"+d')

map('n', '<leader> ', MiniPick.builtin.files, opts)
map('n', '<leader>b', MiniPick.builtin.buffers, opts)
map('n', '<leader>f', MiniPick.builtin.files, opts)
map('n', '<leader>r', MiniExtra.pickers.oldfiles, opts)
map('n', '<leader>g', MiniExtra.pickers.git_files, opts)
map('n', '<leader>s', function() MiniExtra.pickers.lsp({ scope = 'workspace_symbol' }) end, opts)

map('n', '<leader>:', MiniExtra.pickers.commands, opts)
map('n', '<leader>/', MiniPick.builtin.grep_live, opts)

map("n", "<leader>lD", vim.diagnostic.open_float, opts)
map("n", "<leader>ln", vim.diagnostic.goto_next, opts)
map("n", "<leader>lp", vim.diagnostic.goto_prev, opts)
map("n", "<leader>lh", vim.lsp.buf.hover, opts)
map("n", "<leader>ld", vim.lsp.buf.type_definition, opts)
map("n", "<leader>lr", vim.lsp.buf.rename, opts)
map("n", "<leader>lf", vim.lsp.buf.format, opts)
map({ "n", "i" }, "<C-_>", function() vim.lsp.buf.code_action() end, opts)
map('i', '<C-Space>', function() vim.lsp.completion.get() end)

map('i', '<C-j>', function()
	return vim.fn.pumvisible() == 1 and '<C-n>' or '<C-j>'
end, { expr = true, noremap = true })
map('i', '<C-k>', function()
	return vim.fn.pumvisible() == 1 and '<C-p>' or '<C-k>'
end, { expr = true, noremap = true })

