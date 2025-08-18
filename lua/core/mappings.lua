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
vim.keymap.set("n", "<leader>e", ":Neotree toggle reveal<CR>", vim.tbl_extend("force", opts, {
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
vim.keymap.set("n", "<s-l>", ":BufferLineCycleNext<CR>", vim.tbl_extend("force", opts, {
    desc = "Next buffer"
}))
vim.keymap.set("n", "<s-h>", ":BufferLineCyclePrev<CR>", vim.tbl_extend("force", opts, {
    desc = "Previous buffer"
}))
vim.keymap.set("n", "<leader>bd", ":BufferLinePickClose<CR>", vim.tbl_extend("force", opts, {
    desc = "Pick buffer to close"
}))
vim.keymap.set("n", "<leader>bo", ":BufferLineCloseOthers<CR>", vim.tbl_extend("force", opts, {
    desc = "Close other buffers"
}))

vim.keymap.set("v", "<c-m-l>", function()
    vim.cmd("normal! y")
    local var = vim.fn.getreg('"')
    vim.api.nvim_put({"console.log('🤡 ~ ', " .. var .. ");"}, "l", true, true)
end, {
    desc = "Insert console.log with emoji"
})
