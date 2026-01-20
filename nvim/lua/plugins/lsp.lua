return {
	-- ==========================================================================
	-- Mason - LSP/DAP/Linter/Formatter Installer
	-- ==========================================================================
	-- :Mason to open the UI and install servers.
	{
		"mason-org/mason.nvim",
		opts = {},
	},

	-- ==========================================================================
	-- LSP Configuration
	-- ==========================================================================
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			local capabilities = cmp_nvim_lsp.default_capabilities()

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
					end

					-- Navigation
					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
					map("n", "gr", vim.lsp.buf.references, "Show references")
					map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
					map("n", ";", vim.lsp.buf.implementation, "Go to implementation")
					map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")

					-- Information
					map("n", "K", vim.lsp.buf.hover, "Hover documentation")
					map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
					map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

					-- Actions
					map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")

					-- Diagnostics
					map("n", "[d", function()
						vim.diagnostic.jump({ count = -1 })
					end, "Previous diagnostic")
					map("n", "]d", function()
						vim.diagnostic.jump({ count = 1 })
					end, "Next diagnostic")
					map("n", "<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
				end,
			})

			-- Lua
			vim.lsp.config.lua_ls = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = {
					".luarc.json",
					".luarc.jsonc",
					".luacheckrc",
					".stylua.toml",
					"stylua.toml",
					"selene.toml",
					"selene.yml",
					".git",
				},
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			}

			-- TypeScript/JavaScript
			vim.lsp.config.ts_ls = {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
				capabilities = capabilities,
			}

			-- Python
			vim.lsp.config.pyright = {
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_markers = {
					"pyproject.toml",
					"setup.py",
					"setup.cfg",
					"requirements.txt",
					"Pipfile",
					"pyrightconfig.json",
					".git",
				},
				capabilities = capabilities,
			}

			-- HTML
			vim.lsp.config.html = {
				cmd = { "vscode-html-language-server", "--stdio" },
				filetypes = { "html", "templ" },
				root_markers = { "package.json", ".git" },
				capabilities = capabilities,
			}

			-- CSS
			vim.lsp.config.cssls = {
				cmd = { "vscode-css-language-server", "--stdio" },
				filetypes = { "css", "scss", "less" },
				root_markers = { "package.json", ".git" },
				capabilities = capabilities,
			}

			-- JSON
			vim.lsp.config.jsonls = {
				cmd = { "vscode-json-language-server", "--stdio" },
				filetypes = { "json", "jsonc" },
				root_markers = { ".git" },
				capabilities = capabilities,
			}

			vim.lsp.enable({ "lua_ls", "ts_ls", "pyright", "html", "cssls", "jsonls" })

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = true,
				},
			})
		end,
	},

	-- ==========================================================================
	-- nvim-cmp - Completion Engine
	-- ==========================================================================
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				formatting = {
					format = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							buffer = "[Buf]",
							path = "[Path]",
						})[entry.source.name]
						return vim_item
					end,
				},
			})
		end,
	},

	-- ==========================================================================
	-- Mason-LSPConfig
	-- ==========================================================================
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
}
