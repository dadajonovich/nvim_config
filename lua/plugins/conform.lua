return {
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			local conform = require("conform")

			-- настройка форматтеров
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					vue = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					markdown = { "prettier" },
				},
			})

			-- автокоманда для форматирования
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					conform.format({
						bufnr = args.buf,
						async = false,
					})
				end,
			})

			-- автокоманда для organizeImports
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("AutoOrganizeImports", {}),
				pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.vue" },
				callback = function()
					vim.lsp.buf.code_action({
						apply = true,
						context = { only = { "source.organizeImports" }, diagnostics = {} },
					})
				end,
			})

			-- 🔑 клавиша для ручного organizeImports
			vim.keymap.set("n", "<leader>co", function()
				vim.lsp.buf.code_action({
					apply = true,
					context = { only = { "source.organizeImports" }, diagnostics = {} },
				})
			end, { desc = "Organize Imports" })
		end,
	},
}
