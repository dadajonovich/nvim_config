vim.g.mapleader = " "

local function map(mode, lhs, rhs, desc, opts)
	opts = vim.tbl_extend("force", {
		noremap = true,
		silent = true,
		desc = desc,
	}, opts or {})
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Insert
map("i", "jj", "<Esc>", "Escape insert mode")
map("n", "<leader>o", "o<Esc>", "Insert empty line below")
map("n", "<leader>O", "O<Esc>", "Insert empty line above")

-- Buffers
map("n", "<C-s>", ":w<CR>", "Save buffer")

-- Tree
map("n", "<leader>e", ":Neotree toggle reveal<CR>", "Toggle file tree")

-- Window navigation
map("n", "<C-h>", "<C-w>h", "Move to left window")
map("n", "<C-j>", "<C-w>j", "Move to bottom window")
map("n", "<C-k>", "<C-w>k", "Move to top window")
map("n", "<C-l>", "<C-w>l", "Move to right window")

-- Splits
map("n", "|", ":vsplit<CR>", "Vertical split")
map("n", "\\", ":split<CR>", "Horizontal split")

-- BufferLine
map("n", "<S-l>", ":BufferLineCycleNext<CR>", "Next buffer")
map("n", "<S-h>", ":BufferLineCyclePrev<CR>", "Previous buffer")
map("n", "<leader>bd", ":bdelete<CR>", "Close current buffer")
map("n", "<leader>bp", ":BufferLinePickClose<CR>", "Pick buffer to close")
map("n", "<leader>bo", ":BufferLineCloseOthers<CR>", "Close other buffers")

-- Quit
map("n", "<leader>qq", ":q<CR>", "Quit window")
map("n", "<leader>qQ", ":q!<CR>", "Quit without saving")
map("n", "<leader>qa", ":qa<CR>", "Quit all")
map("n", "<leader>qw", ":wq<CR>", "Save & quit")

-- Console.log helper

map("v", "<C-m-l>", function()
	vim.cmd("normal! y")
	local var = vim.fn.getreg('"')
	vim.api.nvim_put({ "console.log('🤡 ~ " .. var .. ":', " .. var .. ");" }, "l", true, true)
end, "Insert console.log with emoji")

return {
	map = map,
}
