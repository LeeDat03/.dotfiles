return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "echasnovski/mini.icons" },
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
		},
		config = function()
			require("nvim-tree").setup({
				view = {
					relativenumber = true,
					width = 35,
				},
				filters = {
					dotfiles = true,
					custom = { ".git", "node_modules", "__pycache__" },
					git_ignored = false,
				},
				disable_netrw = true,
				hijack_netrw = true,
				diagnostics = {
					enable = false, -- Disable LSP diagnostics in the tree
				},
			})
		end,
	},

	{
		"echasnovski/mini.icons",
		-- Load early to ensure icons are available for other plugins
		event = "VimEnter",
		priority = 1000,
		config = function()
			local icons = require("mini.icons")

			icons.setup({
				style = "glyph",
				-- Always show file extension icons
				use_file_extension = function(_, _)
					return true
				end,
			})

			vim.g.loaded_nvim_web_devicons = 1
			package.loaded["nvim-web-devicons"] = nil
			package.preload["nvim-web-devicons"] = function()
				return icons.mock_nvim_web_devicons()
			end
		end,
	},
}
