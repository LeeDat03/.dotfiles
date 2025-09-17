return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
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
						"^Obj$", -- ONLY hide Obj folder, not Object files
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
}
