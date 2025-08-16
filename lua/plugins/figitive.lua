return {
	{ "tpope/vim-fugitive" },
	{
		"rbong/vim-flog",
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
	},
}
