-- Line Numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Indent Settings
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Other
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.termguicolors = true

local spell_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

vim.api.nvim_create_autocmd("FileType", {
	pattern = spell_filetypes,
	callback = function()
		vim.opt.spell = true
		vim.opt.spelllang = { "en", "ru" }
	end,
})
