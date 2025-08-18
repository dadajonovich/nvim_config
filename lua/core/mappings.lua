-- Leader
vim.g.mapleader = " "

-- Общие опции для маппингов
local opts = {
    noremap = true,
    silent = true
}

-- Insert
vim.keymap.set("i", "jj", "<Esc>", vim.tbl_extend("force", opts, {
    desc = "Escape insert mode"
}))

-- Buffers
vim.keymap.set("n", "<c-s>", ":w<CR>", vim.tbl_extend("force", opts, {
    desc = "Save buffer"
}))

-- Tree
vim.keymap.set("n", "<leader>e", ":Neotree right toggle reveal<CR>", vim.tbl_extend("force", opts, {
    desc = "Toggle file tree"
}))

-- Navigation
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", vim.tbl_extend("force", opts, {
    desc = "Move to window up"
}))
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", vim.tbl_extend("force", opts, {
    desc = "Move to window down"
}))
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", vim.tbl_extend("force", opts, {
    desc = "Move to window left"
}))
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", vim.tbl_extend("force", opts, {
    desc = "Move to window right"
}))

-- Splits
vim.keymap.set("n", "|", ":vsplit<CR>", vim.tbl_extend("force", opts, {
    desc = "Vertical split"
}))
vim.keymap.set("n", "\\", ":split<CR>", vim.tbl_extend("force", opts, {
    desc = "Horizontal split"
}))

-- Tabs / BufferLine
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", vim.tbl_extend("force", opts, {
    desc = "Next buffer"
}))
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", vim.tbl_extend("force", opts, {
    desc = "Previous buffer"
}))
vim.keymap.set("n", "<leader>x", ":BufferLinePickClose<CR>", vim.tbl_extend("force", opts, {
    desc = "Pick buffer to close"
}))
vim.keymap.set("n", "<C-x>", ":BufferLineCloseOthers<CR>", vim.tbl_extend("force", opts, {
    desc = "Close other buffers"
}))
