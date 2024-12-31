vim.g.indent_guides_enable_on_vim_startup=1
vim.g.indent_guides_auto_colors = 0

vim.api.nvim_create_autocmd({"VimEnter", "Colorscheme"}, {
  pattern = {"*"},
  command = "hi IndentGuidesOdd  guibg=#081f31"
})

vim.api.nvim_create_autocmd({"VimEnter", "Colorscheme"}, {
  pattern = {"*"},
  command = "hi IndentGuidesEven guibg=#021b2d"
})

-- Do not enable for Nerdtree window
vim.api.nvim_create_autocmd("FileType", { pattern = "nerdtree", command = [[IndentGuidesDisable]] })
