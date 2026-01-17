local keymap = vim.keymap.set

-- ============================================================================
-- Leader Key
-- ============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- General Keymaps
-- ============================================================================
-- Escape to clear search highlighting after a search
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- ============================================================================
-- Window Navigation
-- ============================================================================
-- Ctrl + hjkl to move between split windows instead of Ctrl-w + hjkl
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- ============================================================================
-- Window Resizing
-- ============================================================================
-- Ctrl + Arrow keys to resize the current window
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- ============================================================================
-- Buffer Navigation
-- ============================================================================
-- Shift+L/H to quickly cycle through open buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- ============================================================================
-- Visual Mode Improvements
-- ============================================================================
-- When indenting in visual mode, stay in visual mode instead of returning to normal
keymap("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Move selected lines up or down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ============================================================================
-- Scrolling & Search - Keep Cursor Centered
-- ============================================================================

-- When scrolling half-pages, keep cursor in the middle of the screen
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })

-- When jumping to search results, center the screen on the match
-- Also opens folds if the match is inside a fold (zv)
keymap("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- ============================================================================
-- Paste Behavior
-- ============================================================================

-- When pasting over a selection, don't overwrite the register with the deleted text
keymap("v", "p", '"_dP', { desc = "Paste without losing yanked text" })

-- ============================================================================
-- Quick Actions
-- ============================================================================

-- Faster saving and quitting with leader key
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- ============================================================================
-- Window Splits
-- ============================================================================

-- Create and manage split windows
-- sv = split vertical (side by side)
-- sh = split horizontal (stacked)
-- sx = close current split
keymap("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertical" })
keymap("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split horizontal" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
