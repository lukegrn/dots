-- Luke Green's NVIM config
-- This heavily leverages four main packages for most language support
-- - nvim-lspconfig and everything that goes with it
-- - nvim-cmp for completion via lsp
-- - nvim-treesitter for syntax highlighting
-- - neoformat to format code automatically

require("packer").startup(function()
	use("wbthomason/packer.nvim")

	-- LSP, and completion
	use("neovim/nvim-lspconfig")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-path")

	-- Git integration
	use("tpope/vim-fugitive")

	-- Comment/uncomment lines/whole selections
	use("tpope/vim-commentary")

	-- Show git changes in gutter
	use("mhinz/vim-signify")

	-- Infer indentation rules
	-- This is just a guideline because you should be auto-formatting
	use("tpope/vim-sleuth")

	-- Consistent syntax highlighting across languages
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- Color theme that has colorblind support
	use("EdenEast/nightfox.nvim")

	-- Fuzzy Finding
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Auto formatter
	use("stevearc/conform.nvim")
end)

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
require("nightfox").setup({
	options = {
		colorblind = {
			enable = true,
			severity = {
				protan = 1.0,
				deutan = 0.3,
			},
		},
		inverse = {
			match_paren = true
		}
	},
})
vim.cmd("colorscheme dayfox")

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
