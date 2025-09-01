local M = {}

M.setup = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			map("<leader>cr", vim.lsp.buf.rename, "Rename")
			map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
			map("gr", require("telescope.builtin").lsp_references, "Goto References")
			map("gi", require("telescope.builtin").lsp_implementations, "Goto Implementation")
			map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
			map("gD", vim.lsp.buf.declaration, "Goto Declaration")
			map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
			map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
			map("gt", require("telescope.builtin").lsp_type_definitions, "Goto Type Definition")
			map("<leader>co", function()
				vim.lsp.buf.code_action({
					apply = true,
					context = { only = { "source.organizeImports" }, diagnostics = {} },
				})
			end, "Organize Imports", "n")

			map("K", vim.lsp.buf.hover, "Hover")
			map("gK", vim.lsp.buf.signature_help, "Signature Help")

			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if
				client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
			then
				local highlight_augroup = vim.api.nvim_create_augroup("my-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})
				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("my-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "my-lsp-highlight", buffer = event2.buf })
					end,
				})
			end

			if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				end, "Toggle Inlay Hints")
			end
		end,
	})
end

return M
