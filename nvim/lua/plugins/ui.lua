return {
	{ "nvim-lua/plenary.nvim", lazy = true }, -- lua functions that many plugins use

	-- tabline
	{
		"romgrk/barbar.nvim",
		event = "UIEnter",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"echasnovski/mini.icons",
		},
		init = function()
			vim.g.barbar_auto_setup = false

			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }

			-- Move to previous/next
			map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", opts)
			map("n", "<Tab>", "<Cmd>BufferNext<CR>", opts)

			-- Goto buffer in position...
			map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
			map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
			map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
			map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
			map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
			map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
			map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
			map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
			map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
			map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

			-- Pin/unpin buffer
			map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)

			-- Goto pinned/unpinned buffer
			--                 :BufferGotoPinned
			--                 :BufferGotoUnpinned

			-- Close buffer
			map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
			map("n", "<A-w>", "<Cmd>BufferCloseAllButCurrent<CR>", opts)

			-- Wipeout buffer
			--                 :BufferWipeout

			-- Close commands
			--                 :BufferCloseAllButCurrent
			--                 :BufferCloseAllButPinned
			--                 :BufferCloseAllButCurrentOrPinned
			--                 :BufferCloseBuffersLeft
			--                 :BufferCloseBuffersRight

			-- Magic buffer-picking mode
			map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
			map("n", "<C-s-p>", "<Cmd>BufferPickDelete<CR>", opts)
		end,
		opts = {},
	},

	-- cursor
	{
		"sphamba/smear-cursor.nvim",
		event = "UIEnter",
		opts = {
			stiffness = 0.5,
			trailing_stiffness = 0.5,
			damping = 0.67,
			matrix_pixel_threshold = 0.5,
		},
	},

	-- TODO: key suggest
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {
			spec = {
				{ "<leader>x", group = "Trouble" },
				{ "<leader>f", group = "Telescope" },
				{ "<leader>s", group = "Split" },
				{ "<leader>d", group = "Diffview" },
			},
		},
	},

	-- Statusline
	{
		"echasnovski/mini.statusline",
		version = "*",
		event = "BufReadPost",
		config = function()
			local MiniStatusline = require("mini.statusline")

			local function custom_section_location()
				return "%2l│%-2v" -- Always show "line│column"
			end

			MiniStatusline.setup({
				content = {
					active = function()
						local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
						local git = MiniStatusline.section_git({ trunc_width = 40 })
						local diff = MiniStatusline.section_diff({ trunc_width = 75 })
						local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
						local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })

						local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
						local fileinfo = vim.bo.filetype ~= "" and vim.bo.filetype:lower() or ""

						local location = custom_section_location()
						local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

						return MiniStatusline.combine_groups({
							{ hl = mode_hl, strings = { mode } },
							{ hl = "MiniStatuslineDevinfo", strings = { git } },
							{ hl = "MiniStatuslineDevinfo", strings = { diff } },
							{ hl = "MiniStatuslineDevinfo", strings = { diagnostics } },

							"%<", -- Mark general truncate point
							{ hl = "MiniStatuslineFilename", strings = { filename } },
							"%=", -- End left alignment
							{ hl = "MiniStatuslineFilename", strings = { fileinfo } },
							{ hl = "MiniStatuslineDevinfo", strings = { lsp } },
							{ hl = mode_hl, strings = { search, location } },
						})
					end,
				},
			})
		end,
	},
}
