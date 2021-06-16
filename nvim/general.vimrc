filetype plugin indent on
hi MatchParen cterm=bold ctermbg=black ctermfg=white

" Exit VIM if NERDtree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

let g:ycm_auto_hover=''
set signcolumn=yes
set tabstop=4
set expandtab
set ts=4 sw=4

