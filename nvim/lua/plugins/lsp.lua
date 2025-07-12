return {
	-- Mason
	{
		"mason-org/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	-- {
	-- 	"mason-org/mason-lspconfig.nvim",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	dependencies = {
	-- 		{ "mason-org/mason.nvim", opts = {} },
	-- 		"neovim/nvim-lspconfig",
	-- 	},
	-- 	opts = {
	-- 		automatic_enable = {
	-- 			--			"lua_ls",
	-- 			--			"vimls",
	-- 			"gopls",
	-- 		},
	-- 	},
	-- },

	-- {
	-- 	"nvimdev/lspsaga.nvim",
	-- 	config = function()
	-- 		require("lspsaga").setup({
	-- 			symbol_in_winbar({
	-- 				enable = false,
	--
	-- 			}),
	-- 		})
	-- 	end,
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter", -- optional
	-- 	},
	-- },

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
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			-- Blink to suggest action

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Attach keymap
			local lsp_mappings = {
				{
					"<leader>gd",
					function()
						if vim.bo.filetype == "cs" then
							require("omnisharp_extended").lsp_definitions()
						else
							vim.lsp.buf.definition()
						end
					end,
				},
				{
					"<leader>k",
					function()
						vim.lsp.buf.hover({ border = "single" })
					end,
				},
				{
					"<leader>rn",
					function()
						vim.lsp.buf.rename()
					end,
				},
				{
					"<leader>gr",
					function()
						require("telescope.builtin").lsp_references()
					end,
				},
				{
					"<leader>gt",
					function()
						vim.lsp.buf.type_definition()
					end,
				},
				{
					"<leader>sh",
					function()
						vim.lsp.buf.signature_help()
					end,
				},
				{
					"<leader>ca",
					function()
						vim.lsp.buf.code_action()
					end,
				},
				{
					"<leader>d",
					function()
						vim.diagnostic.open_float(nil, {
							source = "always",
							border = "single",
						})
					end,
				},
			}
			for _, mapping in ipairs(lsp_mappings) do
				vim.keymap.set("n", mapping[1], mapping[2], { noremap = true, silent = true })
			end

			local on_attach = function(client, _)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end

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
				vimls = {},
				gopls = {
					settings = {
						gopls = { staticcheck = true },
					},
				},
			}

			local lspconfig = require("lspconfig")
			for server_name, server_config in pairs(servers) do
				server_config.on_attach = on_attach
				server_config.capabilities = capabilities
				lspconfig[server_name].setup(server_config)
			end
		end,
	},
}
