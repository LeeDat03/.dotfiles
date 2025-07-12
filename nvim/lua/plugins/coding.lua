return {
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

	-- terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		-- keys = {
		-- 	{
		-- 		"<c-\\>", -- Your primary toggle mapping (toggles last active/new)
		-- 		"<cmd>ToggleTerm<cr>",
		-- 		desc = "Toggle terminal",
		-- 	},
		-- },
		keys = {
			{
				"<C-`>",
				"<cmd>ToggleTerm<cr>",
				desc = "Toggle last/default terminal (size 12), or specific index with prefix",
			},
			-- The "<leader>tn" mapping for "new terminal" is still useful if you don't want to type a number
			{
				"<leader>tn", -- Example: 't'erminal 'n'ew (auto-numbered)
				function()
					local terminal = require("toggleterm.terminal")
					local count = terminal.get_next_free_terminal_count()
					-- Using the plugin's native ToggleTerm command to respect 'size = 110' from setup
					vim.cmd("ToggleTerm " .. count)
				end,
				desc = "Open new terminal slot (auto-numbered, uses setup size)",
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
				"echasnovski/mini.icons",
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

	-- Telescope: find text + file
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")
			telescope.setup({
				defaults = {
					path_display = { "truncate" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
					},
				},
			})

			-- set keymaps
			local keymap = vim.keymap -- for conciseness

			keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
			keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
			keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
			keymap.set(
				"n",
				"<leader>fc",
				"<cmd>Telescope grep_string<cr>",
				{ desc = "Find string under cursor in cwd" }
			)
			keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
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
