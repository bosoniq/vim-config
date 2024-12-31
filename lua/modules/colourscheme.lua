vim.opt.termguicolors = true -- enable true colors support
vim.opt.cursorline = false

require("night-owl").setup()
vim.cmd.colorscheme("night-owl")

vim.cmd.highlight({ 'CursorLine', 'guifg=#091f2e guibg=#edb443' })
