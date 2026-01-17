-- UI Enhancements

vim.api.nvim_set_hl(0, "MyDashboardKey", { fg = "#de9f33", bold = true })
return {
	-- ==========================================================================
	-- Bufferline - Tab-like Buffer Bar
	-- ==========================================================================
	-- Shows open buffers as tabs at the top of the screen.
	-- Navigate with Shift+H/L
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Pin buffer" },
			{ "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Close unpinned buffers" },
			{ "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
			{ "<leader>bl", "<cmd>BufferLineCloseRight<CR>", desc = "Close buffers to the right" },
			{ "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", desc = "Close buffers to the left" },
		},
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					themable = true,
					numbers = "none",
					close_command = "bdelete! %d",
					indicator = {
						style = "icon",
						icon = "▎",
					},
					buffer_close_icon = "󰅖",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							text_align = "center",
							separator = true,
						},
					},
					show_buffer_close_icons = true,
					show_close_icon = false,
					separator_style = "thin",
					always_show_bufferline = true,
					auto_toggle_bufferline = true,
				},
			})
		end,
	},

	-- ==========================================================================
	-- Indent Blankline - Indentation Guides
	-- ==========================================================================
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("ibl").setup({
				indent = {
					char = "│",
					tab_char = "│",
				},
				scope = {
					enabled = true,
					show_start = false,
					show_end = false,
				},
				exclude = {
					filetypes = {
						"help",
						"dashboard",
						"neo-tree",
						"lazy",
						"mason",
						"notify",
					},
				},
			})
		end,
	},

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = {
				width = 50,
				enabled = true,
				preset = {
					header = [[.vinter]],
					pick = "telescope.nvim",
					keys = {
						{
							key = "f",
							action = ":lua Snacks.dashboard.pick('files')",
							text = {
								{ "", hl = "SnacksDashboardIcon", width = 2 },
								{ "f", hl = "MyDashboardKey" },
								{ "ind", hl = "SnacksDashboardDesc" },
							},
						},
						{
							key = "g",
							action = ":lua Snacks.dashboard.pick('live_grep')",
							text = {
								{ "", hl = "SnacksDashboardIcon", width = 2 },
								{ "g", hl = "MyDashboardKey" },
								{ "rep", hl = "SnacksDashboardDesc", width = 30 },
							},
						},
						{
							key = "r",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
							text = {
								{ "", hl = "SnacksDashboardIcon", width = 2 },
								{ "r", hl = "MyDashboardKey" },
								{ "ecent", hl = "SnacksDashboardDesc", width = 30 },
							},
						},
					},
				},
				formats = {
					header = { " %s", align = "left", padding = 0 },
				},

				sections = {
					{
						{ header = ".vinter", padding = { 1, 0 } },
					},
					{ section = "keys", gap = 0, padding = { 1, 0 } },
					{
						title = "$ git status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short --branch --renames",
						height = 9,
						padding = 1,
						width = 55,
						ttl = 60,
						indent = 2,
					},
				},
			},
			input = { enabled = true },
			picker = { enabled = true },
			image = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			words = { enabled = true },
			git = { enabled = true },
			gh = { enabled = true },
		},
		keys = {
			{
				"<leader>gi",
				function()
					Snacks.picker.gh_issue()
				end,
				desc = "GitHub Issues (open)",
			},
			{
				"<leader>gI",
				function()
					Snacks.picker.gh_issue({ state = "all" })
				end,
				desc = "GitHub Issues (all)",
			},
			{
				"<leader>gp",
				function()
					Snacks.picker.gh_pr()
				end,
				desc = "GitHub Pull Requests (open)",
			},
			{
				"<leader>gP",
				function()
					Snacks.picker.gh_pr({ state = "all" })
				end,
				desc = "GitHub Pull Requests (all)",
			},
		},
	},

	-- ==========================================================================
	-- Todo Comments - Highlight TODO/FIXME/etc
	-- ==========================================================================
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
			{ "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Find todos" },
		},
		config = function()
			require("todo-comments").setup({})
		end,
	},
}
