-- Set up fuzzy searching to be used by ../init.lua

vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope git_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fs', ':Telescope live_grep<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<cr>', { noremap = true })

