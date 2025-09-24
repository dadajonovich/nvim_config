return {
	--[[ "folke/tokyonight.nvim",
	config = function()
		require("tokyonight").setup({
			style = "storm",
			transparent = false,
			terminal_colors = true,
		})

		vim.cmd("colorscheme tokyonight")
	end, ]]
	"maxmx03/solarized.nvim",
	lazy = false,
	priority = 1000,
	---@type solarized.config
	opts = {},
	config = function(_, opts)
		vim.o.termguicolors = true
		vim.o.background = "dark"
		require("solarized").setup(opts)
		vim.cmd.colorscheme("solarized")
	end,
}
