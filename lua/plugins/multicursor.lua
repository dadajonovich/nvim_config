return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		local map = require("core.mappings").map

		-- Add or skip cursor above/below the main cursor
		map({ "n", "x" }, "<up>", function()
			mc.lineAddCursor(-1)
		end, "Add cursor above")

		map({ "n", "x" }, "<down>", function()
			mc.lineAddCursor(1)
		end, "Add cursor below")

		map({ "n", "x" }, "<leader><up>", function()
			mc.lineSkipCursor(-1)
		end, "Skip cursor above")

		map({ "n", "x" }, "<leader><down>", function()
			mc.lineSkipCursor(1)
		end, "Skip cursor below")

		-- Add or skip adding a new cursor by matching word/selection
		map({ "n", "x" }, "<leader>n", function()
			mc.matchAddCursor(1)
		end, "Add cursor next match")

		map({ "n", "x" }, "<leader>s", function()
			mc.matchSkipCursor(1)
		end, "Skip cursor next match")

		map({ "n", "x" }, "<leader>N", function()
			mc.matchAddCursor(-1)
		end, "Add cursor prev match")

		map({ "n", "x" }, "<leader>S", function()
			mc.matchSkipCursor(-1)
		end, "Skip cursor prev match")

		-- Add and remove cursors with control + left click
		map("n", "<c-leftmouse>", mc.handleMouse, "Add cursor with mouse")
		map("n", "<c-leftdrag>", mc.handleMouseDrag, "Drag to add cursors")
		map("n", "<c-leftrelease>", mc.handleMouseRelease, "Release mouse cursor")

		-- Disable and enable cursors
		map({ "n", "x" }, "<c-q>", mc.toggleCursor, "Toggle cursor enable")

		-- Keymap layer (only when multiple cursors are active)
		mc.addKeymapLayer(function(layerMap)
			layerMap({ "n", "x" }, "<left>", mc.prevCursor)
			layerMap({ "n", "x" }, "<right>", mc.nextCursor)

			layerMap({ "n", "x" }, "<leader>x", mc.deleteCursor)

			layerMap("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)
		end)

		-- Customize how cursors look
		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { reverse = true })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorMatchPreview", { link = "Search" })
		hl(0, "MultiCursorDisabledCursor", { reverse = true })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}
