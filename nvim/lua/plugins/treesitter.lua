return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {
            "lua",
            "javascript",
            "typescript",
            "cpp",
            "zig",
            "go",
        },
        auto_install = true,
        sync_install = false,
        highlight = {
            enable = true,
        },
        additional_vim_regex_highlighting = false,
    }
}
