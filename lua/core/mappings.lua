vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode" })
vim.keymap.set("n", "<leader>o", "o<Esc>", { desc = "Insert empty line below" })
vim.keymap.set("n", "<leader>O", "O<Esc>", { desc = "Insert empty line above" })

vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "|", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "\\", ":split<CR>", { desc = "Horizontal split" })

vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", function()
	require("mini.bufremove").delete(0, false)
end, { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bo", ":BufferLineCloseOthers<CR>", { desc = "Close other buffers" })

vim.keymap.set("n", "<leader>qq", ":q<CR>", { desc = "Quit window" })
vim.keymap.set("n", "<leader>qQ", ":q!<CR>", { desc = "Quit without saving" })
vim.keymap.set("n", "<leader>qa", ":qa<CR>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>qw", ":wq<CR>", { desc = "Save & quit" })

vim.keymap.set("v", "<C-m-l>", function()
	vim.cmd("normal! y")
	local var = vim.fn.getreg('"')
	vim.api.nvim_put({ "console.log('🤡 ~ " .. var .. ":', " .. var .. ");" }, "l", true, true)
end, { desc = "Insert console.log with emoji" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("my-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
