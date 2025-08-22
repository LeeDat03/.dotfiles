return {
	{
		"mason-org/mason.nvim",
		event = "VeryLazy",
		opts = {},

		config = function()
			require("mason").setup({
				ensure_installed = {
					-- "lua_ls",
					-- "gopls",
					-- "html",
					-- "cssls",
					-- "ts_ls",
					-- "prettierd",
				},
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = "VeryLazy",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				automatic_enable = {},
			})
		end,
	},

	{
		"saghen/blink.cmp",
		-- snippet
		dependencies = {
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		version = "1.*",

		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			-- keymap = { preset = "enter" },
			--
			completion = {
				documentation = {
					auto_show = true,
					treesitter_highlighting = true,
					window = { border = "rounded" },
				},
				menu = {
					border = "rounded",

					cmdline_position = function()
						if vim.g.ui_cmdline_pos ~= nil then
							local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
							return { pos[1] - 1, pos[2] }
						end
						local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
						return { vim.o.lines - height, 0 }
					end,

					draw = {
						columns = {
							{ "kind_icon", "label", gap = 1 },
							{ "kind" },
						},
						components = {
							kind_icon = {
								text = function(item)
									local kind = require("lspkind").symbol_map[item.kind] or ""
									return kind .. " "
								end,
								highlight = "CmpItemKind",
							},
							label = {
								text = function(item)
									return item.label
								end,
								highlight = "CmpItemAbbr",
							},
							kind = {
								text = function(item)
									return item.kind
								end,
								highlight = "CmpItemKind",
							},
						},
					},
				},
			},

			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},

			keymap = {
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = {
					function(cmp)
						return cmp.select_next()
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = {
					function(cmp)
						return cmp.select_prev()
					end,
					"snippet_backward",
					"fallback",
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			signature = { enabled = true, window = { border = "single" } },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"neovim/nvim-lspconfig",
		event = { "VeryLazy" },
		dependencies = {
			{ "saghen/blink.cmp" },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- C# lsp
			-- vim.lsp.enable("roslyn_ls")

			-- TS/JS lsp
			vim.lsp.enable("ts_ls")

			-- Go lsp
			vim.lsp.enable("gopls")

			-- Rust lsp
			-- vim.lsp.enable("rust_analyzer")

			vim.lsp.enable("html")
			vim.lsp.enable("cssls")
			vim.lsp.enable("pyright")

			-- vim.lsp.enable("sqlls")

			-- Config server
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								library = {
									vim.fn.expand("$VIMRUNTIME/lua"),
									vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
									"${3rd}/love2d/library",
								},
								checkthirdparty = false,
							},
							telemetry = { enable = false },
						},
					},
				},
				sqlls = {
					settings = {
						sqls = {
							connections = {
								{
									driver = "sqlite",
									dsn = "file:your_database.db?_journal=WAL&_sync=NORMAL",
								},
							},
						},
					},
				},
			}

			for server, config in pairs(servers) do
				config.capabilities = capabilities
				lspconfig[server].setup(config)
			end
		end,
	},
}
