return {
	{
		"neovim/nvim-lspconfig",
		config = function()
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
					vtsls = {
						tsserver = {
							globalPlugins = { vue_plugin },
						},
					},
				},
				filetypes = ts_filetypes,
			})

			-- Регистрация LSP-серверов через vim.lsp.config
			vim.lsp.config("lua_ls", {})
			vim.lsp.config("vue_ls", {})
			vim.lsp.config("stylelint_lsp", {
				filetypes = { "css", "scss" },
				settings = {
					stylelintplus = {
						autoFixOnSave = true,
					},
				},
			})

			-- Автоматическое включение LSP
			vim.lsp.enable({ "lua_ls", "vue_ls", "vtsls", "stylelint_lsp" })

			-- Автокоманды при attach LSP
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
					local opts = {
						buffer = ev.buf,
					}

					-- Клавиши LSP
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.rename, {
						buffer = ev.buf,
						desc = "Rename Symbol",
					})
					vim.keymap.set({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<Leader>lf", function()
						vim.lsp.buf.format({
							async = true,
						})
					end, opts)
				end,
			})
		end,
	},
}
