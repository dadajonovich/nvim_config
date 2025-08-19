return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
			})
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				local map = require("core.mappings").map
				map("t", "<esc>", [[<C-\><C-n>]], "Exit terminal mode", opts)
				map("t", "jj", [[<C-\><C-n>]], "Exit terminal mode (jj)", opts)
				map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], "Move left", opts)
				map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], "Move down", opts)
				map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], "Move up", opts)
				map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], "Move right", opts)
				map("t", "<C-w>", [[<C-\><C-n><C-w>]], "Window commands", opts)
			end
			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
	},
}
