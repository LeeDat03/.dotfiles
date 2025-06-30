return {
	-- Mason
	{
		"mason-org/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			automatic_enable = {
				--			"lua_ls",
				--			"vimls",
				"gopls",
			},
		},
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
			-- Attach keymap
			local on_attach = function(client, bufnr)
				vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

				local bufmap = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
				end

				bufmap("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				bufmap("n", "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				bufmap("n", "K", vim.lsp.buf.hover, "Hover Documentation")
				bufmap("n", "gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				bufmap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				bufmap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				bufmap("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")
				bufmap("n", "<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
				bufmap("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				bufmap("n", "gr", vim.lsp.buf.references, "[G]oto [R]eferences")

				print("LSP server '" .. client.name .. "' started successfully!")
			end

			-- Blink to suggest action
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local servers = {
				lua_ls = {},
				vimls = {},
				--			gopls = {
				--				settings = {
				--					gopls = { staticcheck = true },
				--				},
				--			},
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
