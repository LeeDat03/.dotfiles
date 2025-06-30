return {
	{
		"khoido2003/classic_monokai.nvim",
		event = "UIEnter",
		priority = 1000,
		config = function()
			require("classic_monokai").setup({})

			vim.cmd.colorscheme("classic-monokai")
		end,
	},
}
