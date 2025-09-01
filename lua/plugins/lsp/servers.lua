local M = {}

M.setup = function(cmp_capabilities)
	local vue_language_server_path = vim.fn.stdpath("data")
		.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
	local vue_plugin = {
		name = "@vue/typescript-plugin",
		location = vue_language_server_path,
		languages = { "vue" },
		configNamespace = "typescript",
	}

	local ts_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

	vim.lsp.config("vtsls", {
		settings = {
			vtsls = { tsserver = { globalPlugins = { vue_plugin } } },
		},
		filetypes = ts_filetypes,
		capabilities = cmp_capabilities,
	})

	vim.lsp.config("lua_ls", { capabilities = cmp_capabilities })
	vim.lsp.config("vue_ls", { capabilities = cmp_capabilities })
	vim.lsp.config("stylelint_lsp", {
		filetypes = { "css", "scss" },
		settings = { stylelintplus = { autoFixOnSave = true } },
		capabilities = cmp_capabilities,
	})
	vim.lsp.config("emmet_language_server", { capabilities = cmp_capabilities })
	vim.lsp.config("tailwindcss", { capabilities = cmp_capabilities })

	local base_on_attach = vim.lsp.config.eslint.on_attach
	vim.lsp.config("eslint", {
		on_attach = function(client, bufnr)
			if base_on_attach then
				base_on_attach(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "LspEslintFixAll",
				})
			end
		end,
		capabilities = cmp_capabilities,
	})

	vim.lsp.enable({
		"lua_ls",
		"vue_ls",
		"vtsls",
		"stylelint_lsp",
		"eslint",
		"emmet_language_server",
		"tailwindcss",
	})
end

return M
