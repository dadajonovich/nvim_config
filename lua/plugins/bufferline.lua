return {{
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",
                numbers = "none",
                color_icons = false,
                indicator = {
                    style = "none"
                },
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local s = ""
                    for e, _ in pairs(diagnostics_dict) do
                        local sym = e == "error" and "E" or (e == "warning" and "W" or "I")
                        s = s .. sym
                    end
                    return s ~= "" and " " .. s or ""
                end,
                always_show_bufferline = true
            }
        })
    end
}}
