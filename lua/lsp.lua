local lsps = {
	"lua_ls",
	"ts_ls",
	"tailwindcss",
	"eslint",
	"basedpyright"
}

local treesitter = {
	"lua",
	"javascript",
	"typescript",
	"tsx",
	"python",
	"html",
}

require("mason-lspconfig").setup {ensure_installed = lsps}
vim.lsp.enable(lsps)

-- treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = treesitter,
	modules = {},
	sync_install = false,
	ignore_install = {},
	auto_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
require("nvim-ts-autotag").setup({
	opts = {
		enable_close = true,       -- Auto close tags
		enable_rename = true,      -- Auto rename pairs of tags
		enable_close_on_slash = true -- Auto close on trailing </
	}
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			},
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		}
	}
})

vim.diagnostic.config({
	virtual_lines = {
		-- Only show virtual line diagnostics for the current cursor line
		current_line = true,
	},
	underline = true,
	update_in_insert = true,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
			vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
