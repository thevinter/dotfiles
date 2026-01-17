return {
	-- ==========================================================================
	-- Neo-tree - File Explorer
	-- ==========================================================================
	-- Toggle with Ctrl+E
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazy = "false",
		cmd = "Neotree",
		keys = {
			{ "<C-e>", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
			-- { "<leader>e", "<cmd>Neotree reveal<CR>", desc = "Reveal current file" },
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				popup_border_style = "",
				filesystem = {
					follow_current_file = { enabled = true },
					use_libuv_file_watcher = true,
					filtered_items = {
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_by_name = {
							".git",
							"node_modules",
							"__pycache__",
						},
					},
				},
				window = {
					width = 35,
					mappings = {
						["<space>"] = "none", -- Don't conflict with leader
					},
				},
				default_component_configs = {
					git_status = {
						symbols = {
							added = "+",
							modified = "~",
							deleted = "✖",
							renamed = "➜",
							untracked = "?",
							ignored = "◌",
							unstaged = "○",
							staged = "●",
							conflict = "!",
						},
					},
				},
			})
		end,
	},

	-- ==========================================================================
	-- Conform - Formatting
	-- ==========================================================================
	-- Auto-format on save
	-- Install fotrrmatters via Mason (:Mason)
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Format buffer",
			},
		},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					javascriptreact = { "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "prettierd", "prettier", stop_after_first = true },
					json = { "prettierd", "prettier", stop_after_first = true },
					html = { "prettierd", "prettier", stop_after_first = true },
					css = { "prettierd", "prettier", stop_after_first = true },
					markdown = { "prettierd", "prettier", stop_after_first = true },
					yaml = { "prettierd", "prettier", stop_after_first = true },
				},

				format_on_save = function(bufnr)
					local ignore_filetypes = { "sql" }
					if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
						return
					end
					-- Disable for large files
					local lines = vim.api.nvim_buf_line_count(bufnr)
					if lines > 5000 then
						return
					end
					return {
						timeout_ms = 500,
						lsp_fallback = true,
					}
				end,
			})
		end,
	},

	-- ==========================================================================
	-- nvim-lint - Linting
	-- ==========================================================================
	-- Install linters via Mason (:Mason)
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				python = { "ruff" },
			}

			-- Auto-lint on save and text change
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			-- Manual lint keymap
			vim.keymap.set("n", "<leader>cl", function()
				lint.try_lint()
			end, { desc = "Lint current file" })
		end,
	},

	-- ==========================================================================
	-- Flash.nvim - Fast Navigation
	-- ==========================================================================
	-- Press 's' then type
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = {
			{
				"s",
				function()
					require("flash").jump()
				end,
				mode = { "n", "x", "o" },
				desc = "Flash jump",
			},
		},
		config = function()
			require("flash").setup({
				labels = "asdfghjklqwertyuiopzxcvbnm",
				modes = {
					char = {
						enabled = false,
					},
				},
			})
		end,
	},
}
