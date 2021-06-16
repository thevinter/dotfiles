local g = vim.g
local cmd = vim.cmd
local fn = vim.fn

cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'amix/vim-zenroom2'}                       --Zen mode
paq {'savq/paq-nvim', opt = true}     			--Paq plugin manager
paq {'hrsh7th/vim-vsnip'} 			  			--Snippet manager
paq {'hrsh7th/nvim-compe'} 			  			--Completion 
paq {'nvim-telescope/telescope.nvim'} 			--Telescope Fuzzy Finder
paq {'joshdick/onedark.vim'} 		  			--Dark Theme
paq {'nvim-lua/popup.nvim'}  		  			--Popup manager 
paq {'nvim-lua/plenary.nvim'} 	 	  			--Useful lua functions
paq {'nvim-treesitter/nvim-treesitter'} 		--Treesitter parser 
paq {'georgewfraser/java-language-server'} 		--Java language server 
paq {'etdev/vim-hexcolor'} 						--Hex Color Visualizer
paq {'tpope/vim-surround'} 						--Brackets manager 
paq {'junegunn/fzf', run = fn['fzf#install']}   --Fuzzy Finder 
paq {'junegunn/goyo.vim'}                       --Distraction free
paq {'neovim/nvim-lspconfig'} 					--LSP manager 
paq {'junegunn/fzf.vim'}  						--FZF helper
paq {'ojroques/nvim-lspfuzzy'} 					--configure FZF with LSP
paq {'jiangmiao/auto-pairs'}                    --Auto Brackets
g['deoplete#enable_at_startup'] = 1
