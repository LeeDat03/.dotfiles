return {
	-- Add vim-move for raw line/block movement
	{
		"matze/vim-move",
		config = function()
			vim.g.move_key_modifier = "A" -- Alt as modifier
		end,
	},
	{
		"aaronik/treewalker.nvim",
		opts = {
			highlight = true,
			highlight_duration = 500,
			highlight_group = "CursorLine",
			select = false,
			notifications = true,
			jumplist = true,
		},
		config = function(_, opts)
			require("treewalker").setup(opts)

			-- swapping
			vim.keymap.set("n", "<A-S-k>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
			vim.keymap.set("n", "<A-S-j>", "<cmd>Treewalker SwapDown<cr>", { silent = true })
			vim.keymap.set("n", "<A-S-h>", "<cmd>Treewalker SwapLeft<cr>", { silent = true })
			vim.keymap.set("n", "<A-S-l>", "<cmd>Treewalker SwapRight<cr>", { silent = true })
		end,
	},
	{
		"sindrets/diffview.nvim",
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			local notify = require("notify")
			notify.setup({
				stages = "static",
				timeout = 1500,
				render = "compact",
				max_width = 50,
				max_height = 5,
				fps = 30,
				level = 2,
				top_down = true,
			})

			vim.notify = notify
		end,
	},
	-- Auto pair + auto close
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	-- terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{
				"<C-`>",
				"<cmd>ToggleTerm<cr>",
				desc = "Toggle last/default terminal (size 12), or specific index with prefix",
			},
		},
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-`>]],
				persist_size = true,
				persist_mode = true, -- Corrected typo
				direction = "horizontal",
				size = 110,
				winbar = {
					enabled = false,
				},
				shell = "pwsh",
				term_win_opts = {
					key_bindings = {
						normal_mode = "jk",
					},
				},
			})
		end,
	},
	-- indent
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		opts = {},
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}

			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			require("ibl").setup({
				indent = {
					highlight = highlight,
				},
			})
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "BufReadPost",
	},

	-- hightlight color
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPost",
		lazy = true,
		config = function()
			require("colorizer").setup()
		end,
	},

	-- Markdown render
	{
		{
			"MeanderingProgrammer/render-markdown.nvim",
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
			},
			event = { "BufReadPre *.md", "BufWinEnter *.md" }, -- Load only when a Markdown file is opened
			config = function()
				require("render-markdown").setup({
					syntax_highlighting = true,
					conceal = true,
					markdown_folding = true,
				})
			end,
		},
	},

	-- -- Telescope: find text + file
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				lazy = true,
				config = function()
					require("telescope").load_extension("live_grep_args")
				end,
			},
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local extensions = telescope.extensions
			local themes = require("telescope.themes")

			telescope.setup({
				defaults = {
					path_display = { "smart" },
					mappings = {
						i = {
							["<Esc>"] = require("telescope.actions").close,
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
						},
						n = {
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
						},
					},

					file_ignore_patterns = {
						-- Common junk
						"node_modules",
						"dist",
						"build",
						"target",
						"out",
						"bin",
						"obj",
						"coverage",
						"vendor",
						".venv",
						"venv",
						"__pycache__",
						"%.egg%-info",
						"bower_components",
						"%.pnpm%-store",
						"%.tmp",
						"%.temp",
						"%.cache",
						"%.DS_Store",
						"%.swp",
						"%.swo",
						"%.bak",
						"%.backup",
						"%.pyc",
						"%.pyo",
						"%.class",
						"%.o",
						"%.obj",

						-- Unity-specific
						"^Library/",
						"^Logs/",
						"^Temp/",
						"^Obj/",
						"^Build/",
						"^UserSettings/",
						"^.gradle/",
						"%.csproj$",
						"%.unityproj$",
						"%.sln$",
						"%.pidb$",
						"%.booproj$",
						"%.svd$",
						"%.pdb$",
						"%.mdb$",
						"%.opendb$",
						"%.VC%.db$",
						"%.meta$",

						-- Binaries / media
						"%.jpg$",
						"%.jpeg$",
						"%.png$",
						"%.gif$",
						"%.svg$",
						"%.mp4$",
						"%.mkv$",
						"%.avi$",
						"%.mp3$",
						"%.wav$",
						"%.zip$",
						"%.tar$",
						"%.gz$",
						"%.7z$",
						"%.exe$",
						"%.dll$",
						"%.so$",
						"%.dylib$",
						"%.pdf$",

						-- Misc project noise
						"package%-lock%.json",
						"yarn%.lock",
						"pnpm%-lock%.yaml",
						"%.min%.js$",
						"%.min%.css$",
						"%.map$",
						"%.db$",
						"%.sqlite$",
						"%.sqlite3$",

						-- CI / git noise
						"^.github/",
						"^.gitlab/",
						"%.gitignore$",
						"%.gitattributes$",
						"^.circleci/",
						"%.travis%.yml$",
					},
				},
				pickers = {
					find_files = {
						theme = "dropdown",
						previewer = false,
						hidden = true,
						path_display = { "smart" },
					},
					live_grep = {
						theme = "dropdown",
						previewer = true,
					},
					current_buffer_fuzzy_find = {
						theme = "dropdown",
						previewer = false,
					},
					buffers = {
						sort_lastused = true,
						theme = "dropdown",
						previewer = false,
						path_display = { "smart" },
						mappings = {
							i = {
								["<C-d>"] = "delete_buffer",
							},
							n = {
								["<C-d>"] = "delete_buffer",
							},
						},
					},
					oldfiles = {
						theme = "dropdown",
						previewer = false,
						path_display = { "smart" },
					},
					keymaps = {
						theme = "dropdown",
						layout_config = {
							width = 0.8,
							height = 0.4,
						},
					},
					help_tags = {
						theme = "dropdown",
						previewer = false,
					},
				},
			})

			-- Load extensions
			telescope.load_extension("live_grep_args")

			-- Minimal dropdown keymaps
			local map = vim.keymap.set
			map("n", "<leader>fs", function()
				extensions.live_grep_args.live_grep_args(themes.get_dropdown({ previewer = true }))
			end, { desc = "Live Grep Args (dropdown)" })

			map("n", "<leader>fb", function()
				builtin.current_buffer_fuzzy_find(themes.get_dropdown({ previewer = false }))
			end, { desc = "Fuzzy Find in Buffer (dropdown)" })

			map("n", "<leader>fo", function()
				builtin.oldfiles(themes.get_dropdown({ previewer = false }))
			end, { desc = "Recent Files (dropdown)" })

			map("n", "<leader>fk", function()
				builtin.keymaps(themes.get_dropdown({ previewer = false }))
			end, { desc = "Keymaps (dropdown)" })

			map("n", "<Tab>", function()
				builtin.buffers(themes.get_dropdown({ previewer = false }))
			end, { desc = "Buffers (dropdown)" })

			map("n", "<leader>ff", function()
				builtin.find_files(themes.get_dropdown({ previewer = true, hidden = true }))
			end, { desc = "Find Files (dropdown)" })

			map("n", "<leader>gr", function()
				builtin.lsp_references(themes.get_dropdown({ previewer = false }))
			end, { desc = "LSP References (dropdown)" })
		end,
	},

	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		event = "LspAttach",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle focus=true<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=true win.position=bottom<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=true win.position=bottom<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
