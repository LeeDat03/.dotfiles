return {
	{
		"stevearc/conform.nvim",
		opts = {},
		lazy = true,
		event = "BufWritePre",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "gofmt" },
					html = { "prettierd" },
					css = { "prettierd" },
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
					javascriptreact = { "prettierd" },
					scss = { "prettierd" },
					svelte = { "prettierd" },
					jsx = { "prettierd" },
					tsx = { "prettierd" },
					json = { "prettierd" },
					sql = { "sqlfmt" },
					cs = { "csharpier" },
				},
				formatters = {
					csharpier = {
						command = "dotnet-csharpier",
						args = function()
							local project_dir = vim.fn.expand("%:p:h")
							local csproj_files = vim.fn.glob(project_dir .. "/*.csproj", true, true)
							for _, file in ipairs(csproj_files) do
								if file:match("Assembly%-CSharp%.csproj$") then
									return { "--project", file }
								end
							end

							return {}
						end,
					},
				},
				timeout = 7000,
				debug = true,
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf, async = true })
				end,
			})
		end,
	},
}
