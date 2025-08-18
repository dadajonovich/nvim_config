return {{
    "neovim/nvim-lspconfig",
    config = function()
        local vue_language_server_path = vim.fn.stdpath("data") ..
                                             "/mason/packages/vue-language-server/node_modules/@vue/language-server"
        local vue_plugin = {
            name = "@vue/typescript-plugin",
            location = vue_language_server_path,
            languages = {"vue"},
            configNamespace = "typescript"
        }

        local ts_filetypes = {"typescript", "javascript", "javascriptreact", "typescriptreact", "vue"}

        vim.lsp.config("vtsls", {
            settings = {
                vtsls = {
                    tsserver = {
                        globalPlugins = {vue_plugin}
                    }
                }
            },
            filetypes = ts_filetypes
        })

        -- Регистрация LSP-серверов через vim.lsp.config
        vim.lsp.config("lua_ls", {})
        vim.lsp.config("vue_ls", {})
        vim.lsp.config("stylelint_lsp", {
            filetypes = {"css", "scss"},
            settings = {
                stylelintplus = {
                    autoFixOnSave = true
                }
            }
        })

        -- Автоматическое включение LSP
        vim.lsp.enable({"lua_ls", "vue_ls", "vtsls", "stylelint_lsp"})

        -- Автокоманды при attach LSP
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                local opts = {
                    buffer = ev.buf
                }

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, {
                    desc = "Goto Definition"
                }))
                vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, {
                    desc = "References"
                }))

                vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, {
                    desc = "Hover"
                }))
                vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, {
                    desc = "Signature Help"
                }))

                vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, {
                    desc = "Code Action"
                }))

                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, {
                    desc = "Rename"
                }))

                vim.keymap.set("n", "<Leader>cf", function()
                    vim.lsp.buf.format({
                        async = true
                    })
                end, vim.tbl_extend("force", opts, {
                    desc = "Format Buffer"
                }))

            end
        })
    end
}}
