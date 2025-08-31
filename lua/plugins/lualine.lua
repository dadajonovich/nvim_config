return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local function custom_codeium_status()
				local status = require("codeium.virtual_text").status()
				if status.state == "idle" then
					return "Windsurf"
				elseif status.state == "waiting" then
					return "Waiting..."
				elseif status.state == "completions" and status.total > 0 then
					return string.format("%d/%d", status.current, status.total)
				end
				return "Windsurf"
			end

			require("lualine").setup({
				options = {
					globalstatus = true,
					component_separators = "",
					section_separators = "",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "filename", "branch" },
					lualine_c = { "%=" },
					lualine_x = { custom_codeium_status, "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = { "filename" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { "location" },
				},
			})
		end,
	},
}
