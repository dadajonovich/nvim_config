return {
	"folke/tokyonight.nvim",
	config = function()
		require("tokyonight").setup({
			style = "storm",
			transparent = false,
			terminal_colors = true,
		})

		vim.cmd("colorscheme tokyonight")
	end,
}
