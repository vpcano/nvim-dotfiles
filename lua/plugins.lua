vim.pack.add({
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/smart-splits-nvim/smart-splits.nvim" },
	{ src = "https://github.com/smart-splits-nvim/backend-tmux" },
	{ src = 'https://github.com/saghen/blink.lib' },
	{ src = 'https://github.com/saghen/blink.cmp' },
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" }
})

require("mason").setup()

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
-- custom highlight overrides (reapplied after colorscheme loads)
local set_hl = function()
	-- background-highlight cursorword occurrences instead of underline
	vim.api.nvim_set_hl(0, "MiniCursorword", { link = "LspReferenceText" })
	vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "LspReferenceText" })
	-- dimmer indent scope line
	vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Comment" })
	-- brighter multicursor blocks, using the colorscheme's MiniTrailspace colors
	-- (explicit colors: links don't resolve for the kitty-cursors rendering path)
	local ts = vim.api.nvim_get_hl(0, { name = "MiniTrailspace", link = false })
	vim.api.nvim_set_hl(0, "MCursor", { fg = ts.fg, bg = ts.bg })
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


-- colorscheme
require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
	transparent_background = true,
})
vim.cmd("colorscheme catppuccin")


-- lualine
require "lualine".setup({
	options = {
		theme = "catppuccin-nvim",
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


-- blink cmp
local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
	keymap = {
		preset = 'super-tab',
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = {
		menu = {
			auto_show = function()
				return vim.bo.filetype ~= "markdown"
			end,
		},
		ghost_text = { enabled = true },
	},
	-- signature help while typing function calls (was previously unset)
	signature = { enabled = true },
	sources = { default = { "lsp", "path", "buffer", "snippets" } },
})

