return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					numbers = "none",
					modified_icon = "M",
					indicator = {
						style = "none",
					},
					color_icons = false,
					show_buffer_icons = false,
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local s = " "
						for e, n in pairs(diagnostics_dict) do
							local sym = e == "error" and "E" or (e == "warning" and "W" or "I")
							s = s .. n .. sym
						end
						return s
					end,
					always_show_bufferline = true,
				},
			})
		end,
	},
}
