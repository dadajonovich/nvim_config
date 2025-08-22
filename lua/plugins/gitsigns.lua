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
					map("n", "<leader>gs", gitsigns.stage_hunk, "Stage hunk")
					map("n", "<leader>gr", gitsigns.reset_hunk, "Reset hunk")

					map("v", "<leader>gs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, "Stage hunk (visual)")

					map("v", "<leader>gr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, "Reset hunk (visual)")

					map("n", "<leader>gS", gitsigns.stage_buffer, "Stage entire buffer")
					map("n", "<leader>gR", gitsigns.reset_buffer, "Reset entire buffer")
					map("n", "<leader>gp", gitsigns.preview_hunk, "Preview hunk")
					map("n", "<leader>gi", gitsigns.preview_hunk_inline, "Preview hunk inline")

					map("n", "<leader>gb", function()
						gitsigns.blame_line({ full = true })
					end, "Git blame line (full)")

					map("n", "<leader>gd", gitsigns.diffthis, "Diff this buffer")
					map("n", "<leader>gD", function()
						gitsigns.diffthis("~")
					end, "Diff this buffer (against ~)")

					map("n", "<leader>gQ", function()
						gitsigns.setqflist("all")
					end, "Populate quickfix list (all hunks)")

					map("n", "<leader>gq", gitsigns.setqflist, "Populate quickfix list (open hunks)")

					-- Toggles
					map("n", "<leader>gB", gitsigns.toggle_current_line_blame, "Toggle line blame")
					map("n", "<leader>gW", gitsigns.toggle_word_diff, "Toggle word diff")

					-- Text object
					map({ "o", "x" }, "ig", gitsigns.select_hunk, "Select hunk (inner git)")
				end,
			})
		end,
	},
}
