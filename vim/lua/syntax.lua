-- Tree sitter config
-- Make sure tree sitter cli is installed with `cargo binstall tree-sitter-cli`
require("nvim-treesitter").install({ "python", "go", "lua", "tsx", "typescript", "bash", "http", "json", "tcl" })
