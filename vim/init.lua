-- Luke Green's NVIM config
-- This heavily leverages four main packages for most language support
-- - nvim-lspconfig and everything that goes with it
-- - nvim-cmp for completion via lsp
-- - nvim-treesitter for syntax highlighting
-- - neoformat to format code automatically

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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
	{ "wbthomason/packer.nvim" },

	-- LSP
	{ "neovim/nvim-lspconfig" },

	-- Completion
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-path" },

	-- Git integration
	{ "tpope/vim-fugitive" },

	-- Comment/uncomment lines/whole selections
	{ "tpope/vim-commentary" },

	-- Show git changes in gutter
	{ "mhinz/vim-signify" },

	-- Infer indentation rules
	-- This is just a guideline because you should be auto-formatting
	{ "tpope/vim-sleuth" },

	-- Consistent syntax highlighting across languages
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
	},

	-- Fuzzy Finding
	{
		"nvim-telescope/telescope.nvim",
		version = "v0.2.1",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- optional but recommended
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},

	-- Auto formatter
	{ "stevearc/conform.nvim" },

	-- Theme
	{ "gruvbox-community/gruvbox" },

	-- Database interaction
	{ "xemptuous/sqlua.nvim" },
})

-- Show line numbers
vim.opt.number = true

-- Automatically indent when appropriate
vim.opt.autoindent = true

-- Share clipboard with system
vim.opt.clipboard = "unnamedplus"

-- Quickly react for CursorHold AutoCmd
vim.opt.updatetime = 100

-- Don't highlight last search result
vim.opt.hlsearch = false

-- Don't wrap lines
vim.opt.wrap = false

-- Set colorscheme
vim.cmd([[let g:gruvbox_contrast_dark = 'hard']])
vim.cmd([[colorscheme gruvbox]])

-- Enable colorcolumn for markdown docs
vim.cmd("autocmd FileType markdown set colorcolumn=80")
vim.cmd("autocmd FileType asciidoc set colorcolumn=80")

-- Set up lsp
require("lsp")

-- Set up fuzzy searching
require("fuzzy")

-- Set up completion
require("completion")

-- Set up syntax
require("syntax")

-- Set up auto formatting
require("formatting")

-- Set up helpers
require("helpers")
