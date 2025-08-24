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
				git = {
					enable = true,
					timeout = 5000,
				},
				diagnostics = { enable = false },
				filters = {
					dotfiles = false,
					custom = {
						"node_modules",
						"__pycache__",
						"package-lock.json",
						"Library/*", -- Unity local cache
						"Logs/*", -- Unity log files
						"Temp/*", -- Temp build stuff
						"Obj/*", -- Build object cache
						"Build/*", -- Compiled builds
						"UserSettings/*", -- Local Unity editor settings
						".gradle/*", -- Android builds
						"*.csproj", -- Auto-generated C# project files
						"*.unityproj", -- Old Unity project format
						"*.sln", -- Visual Studio solution
						"*.tmp", -- Temp files
						"*.pidb", -- Unity metadata
						"*.booproj", -- Rider metadata
						"*.svd", -- Debugger files
						"*.pdb", -- Debug symbols
						"*.mdb", -- Debug database
						"*.opendb", -- Local cache
						"*.VC.db", -- VS cache
						"*.meta",
					},
					git_ignored = false,
				},
				disable_netrw = true,
				hijack_netrw = true,
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
