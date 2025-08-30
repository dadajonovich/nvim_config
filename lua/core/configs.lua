vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.mouse = "a"
vim.opt.mousefocus = true

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.termguicolors = true
