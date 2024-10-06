-- vim.opt.guifont = 'Fira Code 11'
-- vim.opt.guifont = 'DeJaVu Sans Mono 11'
-- vim.opt.guifont = 'Noto Sans 10'

vim.opt.number = true
vim.opt.hlsearch = true
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.colorcolumn = '120'
vim.opt.laststatus = 2
vim.opt.completeopt = 'longest,menuone'

vim.cmd('filetype plugin indent on')

-- Auto-close brackets
vim.keymap.set('i', '{', '{}<left>')
vim.keymap.set('i', '{<CR>', '{<CR>}<ESC>O')
vim.keymap.set('i', '{;<CR>', '{<CR>};<ESC>O')

---------------
-- Yank mods --
---------------

-- yank relative path to system clipboard (\crp)
-- vim.keymap.set('n', '<leader>crp', '<cmd>let @+=expand("%")<CR>')

-- yank file name to system clipboard (\cfn)
-- vim.keymap.set('n', '<leader>cfn', '<cmd>let @+=expand("%:t")<CR>')

-- basic mapping to avoid the problem with fast fingers =P
vim.cmd('command! WQ wq')
vim.cmd('command! Wq wq')
vim.cmd('command! W w')
vim.cmd('command! Q q')

-- Make Arrowkey do something usefull, resize the viewports accordingly and
-- it also forces us to use the default Vim movement keys HJKL
vim.keymap.set('n', '<Left>', '<cmd>vertical resize -5<CR>')
vim.keymap.set('n', '<Right>', '<cmd>vertical resize +5<CR>')
vim.keymap.set('n', '<Up>', '<cmd>resize -5<CR>')
vim.keymap.set('n', '<Down>', '<cmd>resize +5<CR>')

-- highlight current line (\hh)
vim.keymap.set('n', '<leader>hh', '<cmd>set cursorline!<CR>')

-- refresh config
vim.keymap.set('n', '<Leader>ref', '<cmd>so ~/.config/nvim/init.vim<CR>')

-- copy to system clipboard
vim.keymap.set('v', '<Leader>sc', '"+y')


---------------
-- Yank mods --
---------------
-- yank relative path to system clipboard (\crp)
vim.keymap.set('n', '<Leader>crp', '<cmd>let @+=expand("%")<CR>')

-- yank file name to system clipboard (\cfn)
vim.keymap.set('n', '<Leader>cfn', '<cmd>let @+=expand("%:t")<CR>')


-----------------
-- Fold config --
-----------------
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 3
vim.opt.foldcolumn = "2"
