-- Tree sitter config
local tree_sitter_langs = { "python", "go", "lua", "tsx", "typescript", "bash", "http", "json" }

require("nvim-treesitter.configs").setup({
	ensure_installed = tree_sitter_langs,
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = tree_sitter_langs,
	},
	indent = {
		enable = true,
	},
})
