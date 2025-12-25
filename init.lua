
-- Basic configuration --
vim.opt.number = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.g.mapleader = ','
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·', extends = '>', precedes = '<', nbsp = '␣' }
vim.opt.cursorline = true

-- Prevent horizontal jittering when scrolling vertically
vim.opt.signcolumn = "yes"  -- Always show sign column to prevent shifting

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Configure plugins
require("lazy").setup({
	-- Dependencies
	"nvim-lua/plenary.nvim",

	-- Telescope and its dependencies
	{
		'nvim-telescope/telescope.nvim',
		branch = 'master',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	-- Harpoon 2
	{
		'ThePrimeagen/harpoon',
		branch = 'harpoon2',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	-- Git gutter
	'airblade/vim-gitgutter',

	-- File manager
	'nvim-tree/nvim-tree.lua',

	-- LSP Config and LSP Installer
	'neovim/nvim-lspconfig',
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',

	-- Completion Framework
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'L3MON4D3/LuaSnip',
	'saadparwaiz1/cmp_luasnip',

	-- LSP UI
	'glepnir/lspsaga.nvim',

	-- Nord theme
	'gbprod/nord.nvim',
})

-----------------------------------------------------------------------------------------------------

-- Telescope Setup and configuration --
require('telescope').setup {
	defaults = {
		prompt_prefix = "> ",
		selection_caret = "> ",
		path_display = {"truncate"},
		sorting_strategy = "ascending",
	},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
		live_grep = {
			theme = "ivy",
		},
	},
	extensions = {
	-- Add extension configurations here if needed
	},
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" })

-----------------------------------------------------------------------------------------------------

-- Harpoon 2 Setup and configuration --
local harpoon = require("harpoon")
harpoon:setup()

-- Keymaps for harpoon 2
vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = "Add File to Harpoon" })
vim.keymap.set('n', '<leader>m', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle Harpoon Menu" })
vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end, { desc = "Harpoon File 1" })
vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end, { desc = "Harpoon File 2" })
vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end, { desc = "Harpoon File 3" })
vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end, { desc = "Harpoon File 4" })

-- Navigate to previous & next buffers in Harpoon list
vim.keymap.set('n', '<C-S-P>', function() harpoon:list():prev() end, { desc = "Harpoon Previous" })
vim.keymap.set('n', '<C-S-N>', function() harpoon:list():next() end, { desc = "Harpoon Next" })

-----------------------------------------------------------------------------------------------------

-- Git Gutter Setup and configuration --
vim.g.gitgutter_map_keys = 0
vim.g.gitgutter_sign_priority = 5
vim.g.gitgutter_sign_added = '▋'
vim.g.gitgutter_sign_modified = '▋'
vim.g.gitgutter_sign_removed = '▋'
vim.g.gitgutter_sign_removed_first_line = '▔'
vim.g.gitgutter_sign_modified_removed = '▋'
vim.g.gitgutter_sign_modified_removed_first_line = '▔'

-----------------------------------------------------------------------------------------------------

-- Nvim-tree Setup and configuration --
require("nvim-tree").setup()

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Toggle File Tree" })

-----------------------------------------------------------------------------------------------------

-- LSP Setup and configuration (Neovim 0.11+ native API) --
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",        -- Lua
		"pyright",       -- Python
		"zls",           -- Zig
		"clangd",        -- C, C++
		"rust_analyzer", -- Rust
		"gopls",         -- Go
		"bashls",        -- Bash
		"elixirls",      -- Elixir
		"ts_ls",         -- TypeScript/JavaScript
		"svelte",        -- Svelte
	},
})

-- Get capabilities from nvim-cmp for LSP completion
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Set global config for all LSP servers
vim.lsp.config('*', {
	capabilities = capabilities,
})

-- Configure lua_ls with custom settings to recognize vim global
vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
}

-- Configure Svelte language server
vim.lsp.config.svelte = {
	settings = {
		svelte = {
			plugin = {
				typescript = {
					enable = true,
					diagnostics = { enable = true },
				},
			},
		},
	},
}

-- Enable all LSP servers
local servers = { "lua_ls", "pyright", "zls", "clangd", "rust_analyzer", "gopls", "bashls", "elixirls", "ts_ls", "svelte" }
for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end

local cmp = require'cmp'

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users
		end,
	},
	mapping = {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept selected item
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	}, {
		{ name = 'buffer' },
	})
})

-- Improved LSP UI
require("lspsaga").setup({
	lightbulb = {
		enable = false,  -- Disable lightbulb to prevent jittering
	},
})

-- General LSP Keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover Documentation" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename Symbol" })
vim.keymap.set('n', 'gR', vim.lsp.buf.rename, { desc = "LSP Rename" })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "References" })

-- Diagnostic Keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show Diagnostic" })

-- General Vim features
vim.opt.autoread = true
vim.opt.updatetime = 5000  -- Check for file changes after 5 seconds of inactivity
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	command = "if mode() != 'c' | checktime | endif",
})

vim.cmd.colorscheme("nord")

