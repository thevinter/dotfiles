local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Hard Vim to break my bad habit
map('n','<Up>','<Nop>')
map('n','<Down>','<Nop>')
map('n','<Left>','<Nop>')
map('n','<Right>','<Nop>')

-- Telescope 
map('n', 'ff', ':Telescope find_files<CR>')

-- compe
map('i','<C-space>','compe#complete()', {silent=true})

-- Spacebar for search
map('n','<Space>','/')
map('n','<C-Space>','?')

-- Zenroom
map('n','<C-z>',':Goyo<cr>')

-- SpellCheck
map('n','<C-s>',':setlocal spell!<cr>')
map('i','<C-l>','<c-g>u<Esc>[s1z=`]a<c-g>u')
