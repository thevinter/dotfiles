-- Plugin Specifications
return {
	-- ==========================================================================
	-- Colorscheme
	-- ==========================================================================
	-- Catppuccin (commented out)
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			flavour = "frappe", -- Options: latte, frappe, macchiato, mocha
	-- 			transparent_background = false,
	-- 			integrations = {
	-- 				treesitter = true,
	-- 				native_lsp = { enabled = true },
	-- 				telescope = true,
	-- 				which_key = true,
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("catppuccin")
	-- 	end,
	-- },

	-- Kanagawa
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				compile = false,
				undercurl = true,
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = false,
				theme = "dragon", -- wave, dragon, lotus
			})
			vim.cmd.colorscheme("kanagawa")
		end,
	},

	-- ==========================================================================
	-- Treesitter - Syntax Highlighting & Code Understanding
	-- ==========================================================================
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" }, -- Load when opening files
		config = function()
			require("nvim-treesitter").install({
				"javascript",
				"css",
				"json",
				"lua",
				"python",
				"typescript",
			})
		end,
	},

	-- ==========================================================================
	-- Which-Key - Keybinding Helper
	-- ==========================================================================
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")
			wk.setup({
				-- Show popup after a short delay
				delay = 300,
			})
			wk.add({
				{ "<leader>b", group = "Buffer" },
				{ "<leader>c", group = "Code" },
				{ "<leader>e", desc = "File explorer" },
				{ "<leader>f", group = "Find" },
				{ "<leader>g", group = "Git" },
				{ "<leader>s", group = "Split" },
			})
		end,
	},

	-- ==========================================================================
	-- Telescope - Fuzzy Finder
	-- ==========================================================================
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				-- Native FZF sorter for better performance
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		cmd = "Telescope",
		keys = {
			-- File finding
			{ "ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
			{ "fg", "<cmd>Telescope live_grep<CR>", desc = "Grep in files" },
			{ "fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
			-- Git
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git status" },
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					-- Put the prompt at the top
					prompt_prefix = "   ",
					selection_caret = " ",
					path_display = { "truncate" },
					file_ignore_patterns = {
						"node_modules",
						".git/",
						"dist/",
						"build/",
						"target/",
					},
				},
			})
			telescope.load_extension("fzf")
		end,
	},

	-- ==========================================================================
	-- mini.pairs: Auto-close brackets, quotes, etc.
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		config = function()
			require("mini.pairs").setup()
		end,
	},

	-- mini.surround: Add/change/delete surrounding pairs
	-- sa = surround add, sd = surround delete, sr = surround replace
	{
		"echasnovski/mini.surround",
		config = function()
			require("mini.surround").setup()
		end,
	},

	-- mini.comment: Toggle comments with gc
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		config = function()
			require("mini.comment").setup()
		end,
	},

	-- ==========================================================================
	-- Gitsigns - Git Integration in the Gutter
	-- ==========================================================================
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local function map(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
					end
					-- Navigation between hunks (changed sections)
					map("n", "]h", gs.next_hunk, "Next git hunk")
					map("n", "[h", gs.prev_hunk, "Previous git hunk")
					-- Actions
					map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
					map("n", "<leader>gb", gs.blame_line, "Blame line")
				end,
			})
		end,
	},

	-- ==========================================================================
	-- Lualine - Status Line
	-- ==========================================================================
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = { "snacks_dashboard" },
						winbar = { "snacks_dashboard" },
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
