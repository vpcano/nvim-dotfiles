vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/smart-splits-nvim/smart-splits.nvim" },
	{ src = "https://github.com/smart-splits-nvim/backend-tmux" },
})

require "mason".setup()

-- mini
require("mini.ai").setup({})
require("mini.move").setup({})
require("mini.comment").setup({})
require("mini.jump").setup({})
require("mini.trailspace").setup({})
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons() -- let plugins expecting nvim-web-devicons (e.g. lualine) use mini.icons
require("mini.pairs").setup()
require("mini.surround").setup({
	mappings = {
    add = 'Sa', -- Add surrounding in Normal and Visual modes
    delete = 'Sd', -- Delete surrounding
    find = 'Sf', -- Find surrounding (to the right)
    find_left = 'SF', -- Find surrounding (to the left)
    highlight = 'Sh', -- Highlight surrounding
    replace = 'Sr', -- Replace surrounding

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
	}
})
require("mini.diff").setup({
	view = {
		style = "sign",
		signs = { add = "▎", change = "▎", delete = "▎" },
	},
})
local indentscope = require("mini.indentscope")
indentscope.setup({
	symbol = "│",
	draw = {
		delay = 0,
		animation = indentscope.gen_animation.none(),
	},
})
require("mini.cursorword").setup()
-- custom highlight overrides (reapplied after colorscheme loads)
local set_hl = function()
	-- background-highlight cursorword occurrences instead of underline
	vim.api.nvim_set_hl(0, "MiniCursorword", { link = "LspReferenceText" })
	vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "LspReferenceText" })
	-- dimmer indent scope line
	vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Comment" })
end
set_hl()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
require("mini.notify").setup()
vim.notify = MiniNotify.make_notify()
require("mini.pick").setup()
require("mini.extra").setup()
vim.ui.select = MiniPick.ui_select
local statuscolumn = require('mini.statuscolumn')
local spec = {
  { format = 'fs=l', sep = '│ ' },
  -- { format = 'fs=l', sep = '  ' },
  { ltype = 'virt', lnum = '•' },
  { ltype = 'wrap', lnum = '↳' },
}
statuscolumn.setup({ content = statuscolumn.gen_content.main(spec) })


-- samrt splits (tmux compatibility)
require "smart-splits".setup({
	mux = { backend = 'smart-splits-backend-tmux' },
	move = { at_edge = 'wrap' },
	resize = { amount = 3 },
})

vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)

vim.keymap.set('n', '<C-M-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<C-M-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<C-M-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<C-M-l>', require('smart-splits').resize_right)


-- vague colorscheme
require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")


-- lualine
require "lualine".setup({
	options = {
		theme = "OceanicNext",
		component_separators = { left = '|', right = '|' },
		section_separators = { left = ' ', right = ' ' },
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff' },
		lualine_c = { 'filename', 'searchcount' },
		lualine_x = { 'diagnostics', 'lsp_status' },
		lualine_y = { 'filetype' },
		lualine_z = { 'progress', 'location' }
	}
})

