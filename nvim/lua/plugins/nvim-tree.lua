return {
	{
		"aaronik/treewalker.nvim",
		opt = {
			highlight = true,
			highlight_duration = 500,
			highlight_group = "CursorLine",
			select = false,
			notifications = true,
			jumplist = true,
		},
		config = function()
			-- movement
			vim.keymap.set({ "n", "v" }, "<A-k>", "<cmd>Treewalker Up<cr>", { silent = true })
			vim.keymap.set({ "n", "v" }, "<A-j>", "<cmd>Treewalker Down<cr>", { silent = true })
			vim.keymap.set({ "n", "v" }, "<A-h>", "<cmd>Treewalker Left<cr>", { silent = true })
			vim.keymap.set({ "n", "v" }, "<A-l>", "<cmd>Treewalker Right<cr>", { silent = true })

			-- swapping
			vim.keymap.set({ "n" }, "<A-S-k>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
			vim.keymap.set({ "n" }, "<A-S-j>", "<cmd>Treewalker SwapDown<cr>", { silent = true })
			vim.keymap.set({ "n" }, "<A-S-h>", "<cmd>Treewalker SwapLeft<cr>", { silent = true })
			vim.keymap.set({ "n" }, "<A-S-l>", "<cmd>Treewalker SwapRight<cr>", { silent = true })
		end,
	},
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
}
