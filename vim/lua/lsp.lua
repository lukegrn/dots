-- This sets up LSP to be used by ../init.lua

local lsp = require("lspconfig")

-- LSP completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Define useful LSP keybindings
-- -- Leader+e => show error at point
-- -- Leader+i => show info at point
local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>i", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
	vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, bufopts)
end

-- LSP defaults, can be overridden or added upon per-lang
local default_setup = {
	on_attach = on_attach,
	capabilities = capabilities,
	-- handlers = handlers
}

-- Set up languages

-- Typescript
-- -- If not installed, do so with npm i -g typescript-language-server
lsp.ts_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Gopls
-- -- If not installed, do so with go install golang.org/x/tools/gopls@latest
lsp.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Python
-- -- If not installed, do so with npm i -g pyright
lsp.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- Rust
-- -- If not installed, do so with rustup component add rust-analyzer
lsp.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
