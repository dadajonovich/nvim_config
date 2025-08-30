return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'j-hui/fidget.nvim', opts = {} },
        'saghen/blink.cmp',
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('my-lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end
                map('<leader>cr', vim.lsp.buf.rename, 'Rename')
                map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
                map('gr', require('telescope.builtin').lsp_references, 'Goto References')
                map('gi', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
                map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
                map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
                map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
                map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
                map('gt', require('telescope.builtin').lsp_type_definitions, 'Goto Type Definition')
                map('<leader>co', function()
                    vim.lsp.buf.code_action({
                        apply = true,
                        context = {
                            only = { "source.organizeImports" },
                            diagnostics = {},
                        },
                    })
                end, 'Organize Imports', 'n')
                map('<leader>cd', vim.diagnostic.open_float, 'Show Line Diagnostics')
                map('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
                map(']d', vim.diagnostic.goto_next, 'Next Diagnostic')
                map('<leader>xx', vim.diagnostic.setloclist, 'All Diagnostics')
                map('K', vim.lsp.buf.hover, 'Hover')
                map('gK', vim.lsp.buf.signature_help, 'Signature Help')


                local function client_supports_method(client, method, bufnr)
                    return client:supports_method(method, bufnr)
                end

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup('my-lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('my-lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'my-lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end

                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, 'Toggle Inlay Hints')
                end
            end,
        })

        vim.diagnostic.config {
            severity_sort = true,
            float = { border = 'rounded', source = 'if_many' },
            underline = { severity = vim.diagnostic.severity.ERROR },
            signs = true,
            virtual_text = {
                source = 'if_many',
                spacing = 2,
                format = function(diagnostic)
                    return diagnostic.message
                end,
            },
        }

        local cmp_capabilities = require('blink.cmp').get_lsp_capabilities()

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

        vim.lsp.config("emmet_language_server", {
            capabilities = cmp_capabilities,
        })

        vim.lsp.config("tailwindcss", {
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
            "eslint",
            "emmet_language_server",
            "tailwindcss",
        })
    end,
}
