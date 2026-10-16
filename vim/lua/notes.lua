-- Depends on pandoc and xelatex, make sure both are installed

local pandoc_pdf_ops = {
	"--pdf-engine=xelatex",
	"-V",
	"geometry:margin=1in",
	"-V",
	"monofont=JetBrainsMono-Regular.otf",
	"-V",
	"mainfont=Montserrat-Light.otf",
	"-V",
	"mainfontoptions:BoldFont=Montserrat-Medium.otf,ItalicFont=Montserrat-LightItalic.otf,BoldItalicFont=Montserrat-MediumItalic.otf",
	"-V",
	"fontsize=10pt",
	"--lua-filter",
	"wrapfig.lua",
	"--template",
	"wrapfig",
}

-- Convert current Markdown file to PDF using Pandoc
vim.keymap.set("n", "<leader>mp", function()
	-- Get the current file path and the target PDF path
	local file = vim.fn.expand("%")
	local pdf = vim.fn.expand("%:r") .. ".pdf"

	local cmd = {
		"pandoc",
		file,
	}

	for _, v in ipairs(pandoc_pdf_ops) do
		table.insert(cmd, v)
	end

	table.insert(cmd, "-o")
	table.insert(cmd, pdf)

	vim.system(cmd, {}, function(obj)
		vim.schedule(function()
			if obj.code == 0 then
				vim.notify("Successfully converted to PDF!", vim.log.levels.INFO)
			else
				local error_msg = obj.stderr ~= "" and obj.stderr or "Unknown error occurred."

				vim.notify("Pandoc failed (Exit code " .. obj.code .. "):\n" .. error_msg, vim.log.levels.ERROR)
			end
		end)
	end)
end, { desc = "Convert Markdown to PDF with Pandoc", silent = true })

-- Convert Markdown files in current directory to PDF using pandoc
-- These are always arranged in alphabetical order, so a date stamp of
-- Y-m-d is the most stable
-- Uses the current directory and its parent to create the pdf name
vim.keymap.set("n", "<leader>dp", function()
	local cwd = vim.fn.getcwd() -- Get current working directory
	local files = vim.split(vim.fn.glob(cwd .. "/*.md"), "\n", { trimempty = true })

	local parts = vim.split(cwd, "/", { trimempty = true })
	local pdf = parts[#parts - 1] .. "_" .. parts[#parts] .. ".pdf"

	table.sort(files) -- put them in alphabetical order

	local cmd = {
		"pandoc",
		"-s",
	}

	for _, file in ipairs(files) do
		table.insert(cmd, file)
	end

	for _, v in ipairs(pandoc_pdf_ops) do
		table.insert(cmd, v)
	end

	table.insert(cmd, "-o")
	table.insert(cmd, pdf)

	vim.system(cmd, {}, function(obj)
		vim.schedule(function()
			if obj.code == 0 then
				vim.notify("Successfully converted entire directory to PDF!", vim.log.levels.INFO)
			else
				local error_msg = obj.stderr ~= "" and obj.stderr or "Unknown error occurred."

				vim.notify("Pandoc failed (Exit code " .. obj.code .. "):\n" .. error_msg, vim.log.levels.ERROR)
			end
		end)
	end)
end)

-- Convert current Markdown file to PDF using Pandoc
vim.keymap.set("n", "<leader>ap", function()
	-- Get the current file path and the target PDF path
	local file = vim.fn.expand("%")

	local cmd = {
		"asciidoctor-pdf",
		file,
	}

	vim.system(cmd, {}, function(obj)
		vim.schedule(function()
			if obj.code == 0 then
				vim.notify("Successfully converted to PDF!", vim.log.levels.INFO)
			else
				local error_msg = obj.stderr ~= "" and obj.stderr or "Unknown error occurred."

				vim.notify("asciidoctor failed (Exit code " .. obj.code .. "):\n" .. error_msg, vim.log.levels.ERROR)
			end
		end)
	end)
end, { desc = "Convert adoc to PDF with asciidoctor", silent = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "asciidoc" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "en_us" }
		vim.opt_local.textwidth = 80
		vim.opt_local.formatoptions:append("t")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "en_us" }
	end,
})
