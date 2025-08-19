return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local map = require("core.mappings").map

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, "Next git hunk")

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, "Previous git hunk")

					-- Actions
					map("n", "<leader>gS", gitsigns.stage_buffer, "Stage entire buffer")
					map("n", "<leader>gR", gitsigns.reset_buffer, "Reset entire buffer")
					map("n", "<leader>gp", gitsigns.preview_hunk, "Preview hunk")
					map("n", "<leader>gd", gitsigns.diffthis, "Diff this buffer")
					map({ "o", "x" }, "ig", gitsigns.select_hunk, "Select hunk (inner git)")
				end,
			})
		end,
	},
}
