return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

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
				capabilities = cmp_capabilities,
			})

			vim.lsp.config("lua_ls", {
				capabilities = cmp_capabilities,
			})
			vim.lsp.config("vue_ls", {
				capabilities = cmp_capabilities,
			})
			vim.lsp.config("stylelint_lsp", {
				filetypes = { "css", "scss" },
				settings = {
					stylelintplus = {
						autoFixOnSave = true,
					},
				},
				capabilities = cmp_capabilities,
			})

			vim.lsp.config("css_variables", {
				filetypes = ts_filetypes,
				capabilities = cmp_capabilities,
			})

			vim.lsp.config("cssls", {
				capabilities = cmp_capabilities,
			})

			vim.lsp.config("cssmodules_ls", {
				filetypes = ts_filetypes,
				capabilities = cmp_capabilities,
			})

			local base_on_attach = vim.lsp.config.eslint.on_attach
			vim.lsp.config("eslint", {
				on_attach = function(client, bufnr)
					if not base_on_attach then
						return
					end

					base_on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "LspEslintFixAll",
					})
				end,
				capabilities = cmp_capabilities,
			})

			vim.lsp.enable({
				"lua_ls",
				"vue_ls",
				"vtsls",
				"stylelint_lsp",
				"cssmodules_ls",
				"css_variables",
				"cssls",
				"eslint",
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					local map = require("core.mappings").map
					local opts = {
						buffer = ev.buf,
					}

					-- LSP navigation
					map("n", "gd", vim.lsp.buf.definition, "Goto Definition", opts)
					map("n", "gr", vim.lsp.buf.references, "References", opts)
					map("n", "K", vim.lsp.buf.hover, "Hover", opts)
					map("n", "gK", vim.lsp.buf.signature_help, "Signature Help", opts)
					map("n", "<leader>cd", function()
						vim.diagnostic.open_float(0, {
							scope = "cursor",
							focusable = false,
							close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave" },
						})
					end, "Show Diagnostics", opts)

					-- Code actions
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action", opts)
					map("n", "<leader>cr", vim.lsp.buf.rename, "Rename", opts)

					-- Formatting
					map("n", "<leader>cf", function()
						vim.lsp.buf.format({
							async = true,
						})
					end, "Format Buffer", opts)

					map("n", "<leader>co", function()
						vim.lsp.buf.code_action({
							apply = true,
							context = {
								only = { "source.organizeImports" },
								diagnostics = {},
							},
						})
					end, "Organize Imports")
				end,
			})
		end,
	},
}
