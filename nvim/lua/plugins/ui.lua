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

			-- keymap to delete buffer
			vim.keymap.set("n", "<leader>bd", function()
				local bufnr = vim.api.nvim_get_current_buf() -- Get current buffer ID
				local other_buf = vim.fn.bufnr("#") -- Get alternate buffer

				-- Check if an alternate buffer exists and is valid
				if other_buf > 0 and vim.api.nvim_buf_is_valid(other_buf) then
					vim.api.nvim_set_current_buf(other_buf) -- Switch to alternate buffer
				end

				-- Delete the current buffer
				vim.cmd("bd " .. bufnr)
			end, { silent = true, desc = "Close current buffer" })
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
