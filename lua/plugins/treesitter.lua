return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
        ensure_installed = { "lua", "html", "typescript", "javascript", "vue", "markdown" },
        auto_install = true,
        highlight = {
            enable = true,
        },
    },
}
