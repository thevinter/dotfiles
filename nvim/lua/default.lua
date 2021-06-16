local cmd = vim.cmd
local o = vim.opt

vim.o.completeopt = "menuone,noselect"
o.termguicolors = true
cmd("colorscheme onedark")
o.number = true
o.relativenumber = true
o.ignorecase = true
o.list = true
vim.o.tabstop = 2
o.ts = 4
o.expandtab = true
o.joinspaces = true
o.splitbelow = true
o.splitright = true
o.smartcase = true

-- Incremental Live Completion 
o.inccommand = "nosplit"
o.hlsearch = false
o.incsearch = true

-- Spelling
o.spelllang="en,it"
