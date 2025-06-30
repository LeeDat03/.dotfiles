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
			"gomod",
			"vim",
			"vimdoc",
		},
		auto_install = true,
		sync_install = true,
		highlight = {
			enable = true,
		},
		additional_vim_regex_highlighting = false,
		indent = {
			enable = true,
		},
	},
}
