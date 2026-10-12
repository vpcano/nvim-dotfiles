vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/mikavilpas/yazi.nvim" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/mrjones2014/smart-splits.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/NickvanDyke/opencode.nvim" },
	{ src = "https://github.com/zbirenbaum/copilot.lua" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
})

require "mason".setup()
require "nvim-web-devicons".setup()
require "nvim-autopairs".setup {}
require "gitsigns".setup {}
require "smart-splits".setup {}

-- snacks
---@diagnostic disable-next-line: duplicate-set-field
vim.deprecate = function() end -- avoid deprecated warning
require('snacks').setup({
	dim = { enabled = true },
	indent = { enabled = true },
	input = {
		enabled = true,
		win = {
			relative = 'cursor'
		}
	},
	bigfile = { enabled = true },
	dashboard = { enabled = false },
	explorer = { enabled = false },
	notifier = {
		enabled = true,
		top_down = false,
		margin = { bottom = 2 }
	},
	notify = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	animate = { enabled = true },
	scroll = { enabled = true },
	image = { enabled = true },
	scope = { enabled = true },
	picker = {
		enabled = true,
		ui_select = true,
		layouts = {
			select = {
				layout = {
					relative = 'cursor',
				},
			},
		},
	},
})


-- yazi
require("yazi").setup({
	open_for_directories = true,
	integrations = {
		grep_in_directory = function(directory)
			require("snacks.picker").grep({ search_dirs = { directory } })
		end,
		grep_in_selected_files = function(selected_files)
			require("snacks.picker").grep({ search_dirs = selected_files })
		end,
	}
})


-- vague colorscheme
require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")


-- treesitter
require 'nvim-treesitter.configs'.setup {
	ensure_installed = {
		"lua",
		"javascript",
		"typescript",
		"tsx",
	},
	modules = {},
	sync_install = false,
	ignore_install = {},
	auto_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}
require('nvim-ts-autotag').setup({
	opts = {
		-- Defaults
		enable_close = true,       -- Auto close tags
		enable_rename = true,      -- Auto rename pairs of tags
		enable_close_on_slash = true -- Auto close on trailing </
	}
})


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


-- opencode
vim.g.opencode_opts = {}
vim.opt.autoread = true

-- Listen for opencode events
vim.api.nvim_create_autocmd("User", {
	pattern = "OpencodeEvent",
	callback = function(args)
		if args.data.type == "session.idle" then
			vim.notify("Opencode finished responding", vim.log.levels.INFO)
		end
	end,
})


-- copilot
require('copilot').setup({
	suggestion = {
		auto_trigger = true,
	}
})
