-- Lsp completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Define useful LSP keybindings
-- -- Leader+e => show error at point
-- -- Leader+i => show info at point
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(ev)
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "<leader>i", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, bufopts)
	end,
})

-- Define all supported languages
local langs = {
	"ts_ls", -- If not installed, do so with npm i -g typescript-language-server
	"gopls", -- If not installed, do so with go install golang.org/x/tools/gopls@latest
	"pyright", -- If not installed, do so with npm i -g pyright
	"rust_analyzer", -- If not installed, do so with rustup component add rust-analyzer
	"ocamllsp", -- If not installed, do so with opam install ocaml-lsp-server
	"tclsp", -- If not installed, do so with pip install tclint
	"clangd", -- If not installed, dnf/brew install clangd/llvm
}

vim.lsp.config("*", {
	capabilities = capabilities,
})

for _, lang in ipairs(langs) do
	vim.lsp.enable(lang)
end
