-- Insert timestamp
local insert_datestamp = function()
	local date = os.date("%A, %B %d, %Y")
	vim.api.nvim_put({ date }, "c", true, true)
end
vim.keymap.set("n", "<C-s>", insert_datestamp, { desc = "Insert current date" })
vim.keymap.set("i", "<C-s>", insert_datestamp, { desc = "Insert current date" })
