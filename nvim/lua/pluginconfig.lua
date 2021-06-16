local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', nighlight =  {enable = true}}

local fn = vim.fn
require'lspconfig'.java_language_server.setup{}

