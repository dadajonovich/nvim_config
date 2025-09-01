local M = {}

M.setup = function()
	vim.diagnostic.config({
		severity_sort = true,
		float = { border = "rounded", source = "if_many" },
		underline = true,
		signs = true,
		virtual_text = false,
	})
end

return M
