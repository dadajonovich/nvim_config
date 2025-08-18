return {{
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {{
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
        mode = "n"
    }, {
        "<leader>cS",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP references/definitions/... (Trouble)",
        mode = "n"
    }, {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
        mode = "n"
    }, {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
        mode = "n"
    }, {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle focus=true<cr>",
        desc = "Diagnostics (Trouble)",
        mode = "n"
    }, {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
        mode = "n"
    }, -- Navigation inside Trouble / Quickfix
    {
        "[q",
        "<cmd>Trouble previous<cr>",
        desc = "Previous Trouble/Quickfix Item",
        mode = "n"
    }, {
        "]q",
        "<cmd>Trouble next<cr>",
        desc = "Next Trouble/Quickfix Item",
        mode = "n"
    }}
}}
