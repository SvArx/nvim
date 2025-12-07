
-- Basic configuration --
vim.opt.number = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.g.mapleader = ','
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·', extends = '>', precedes = '<', nbsp = '␣' }
vim.opt.cursorline = true

-- Define a function to ensure packer is installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		print("Packer not found. Installing...")
		fn.system({
			'git',
			'clone',
			'--depth', '1',
			'https://github.com/wbthomason/packer.nvim',
			install_path
	})
		vim.cmd [[packadd packer.nvim]]
		print("Packer installed. Restart Neovim to load it.")
		return true
	end
	return false
end

-- Automatically install packer if not already installed
local packer_bootstrap = ensure_packer()

-- Use a protected call to ensure packer is loaded
local ok, packer = pcall(require, 'packer')
if not ok then
    vim.notify("Packer is not available. Please check the installation.", vim.log.levels.ERROR)
    return
end

-- Configure packer
packer.startup(function(use)
	-- Packer manages itself
	use 'wbthomason/packer.nvim'

	-- Dependencies
	use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!

	-- Telescope and its dependencies --
	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.3', -- Use the latest stable release (or remove this line for the latest commit)
		requires = { {'nvim-lua/plenary.nvim'} } -- Telescope's dependency
	}

	-- Harpoon2
	use 'ThePrimeagen/harpoon'

	-- Git gutter
	use 'airblade/vim-gitgutter'

	-- File manager
	use 'nvim-tree/nvim-tree.lua'

	-- LSP Config and LSP Installer
	use 'neovim/nvim-lspconfig' -- Core LSP configurations
	use 'williamboman/mason.nvim' -- LSP/DAP/formatters installer
	use 'williamboman/mason-lspconfig.nvim' -- Bridge between mason and lspconfig

	-- Completion Framework
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
	use 'hrsh7th/cmp-buffer' -- Buffer completions
	use 'hrsh7th/cmp-path' -- Path completions
	use 'hrsh7th/cmp-cmdline' -- Command line completions
	use 'L3MON4D3/LuaSnip' -- Snippet engine
	use 'saadparwaiz1/cmp_luasnip' -- Snippet completions

	-- Optional: Nice UI for diagnostics, code actions, etc.
	use 'glepnir/lspsaga.nvim'

	-- kanagawa theme
	use 'gbprod/nord.nvim'

	-- Automatically set up configuration after cloning packer.nvim
	-- This must be placed at the end of all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)

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

-- Require harpoon --
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
local harpoon_term = require("harpoon.term")

-- Keymaps for harpoon
vim.keymap.set('n', '<leader>a', harpoon_mark.add_file, { desc = "Add File to Harpoon" })
vim.keymap.set('n', '<leader>m', harpoon_ui.toggle_quick_menu, { desc = "Toggle Harpoon Menu" })
vim.keymap.set('n', '<leader>1', function() harpoon_ui.nav_file(1) end, { desc = "Harpoon File 1" })
vim.keymap.set('n', '<leader>2', function() harpoon_ui.nav_file(2) end, { desc = "Harpoon File 2" })
vim.keymap.set('n', '<leader>3', function() harpoon_ui.nav_file(3) end, { desc = "Harpoon File 3" })
vim.keymap.set('n', '<leader>4', function() harpoon_ui.nav_file(4) end, { desc = "Harpoon File 4" })
vim.keymap.set('n', '<leader>tt', function() harpoon_term.gotoTerminal(1) end, { desc = "Harpoon Terminal 1" })
vim.keymap.set('n', '<leader>tn', function() harpoon_term.gotoTerminal(2) end, { desc = "Harpoon Terminal 2" })


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

-- LSP Setup and configuration --
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
	},
})

local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Lua server with custom settings
lspconfig.lua_ls.setup {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } }, -- Recognize 'vim' as a global
		},
	},
}

-- Automatically set up all other installed servers
local servers = { "pyright", "zls", "clangd", "rust_analyzer", "gopls", "bashls", "elixirls" }
for _, server in ipairs(servers) do
	lspconfig[server].setup {
		capabilities = capabilities,
	}
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
require("lspsaga").setup({})

-- General LSP Keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover Documentation" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename Symbol" })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = "References" })

-- Diagnostic Keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show Diagnostic" })

-- Colorshema
vim.cmd.colorscheme("nord")
