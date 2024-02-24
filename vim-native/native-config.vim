"""""""""""""""
"" Yank mods ""
"""""""""""""""
" yank relative path to system clipboard (\crp)
nnoremap <leader>crp :let @+=expand("%")<CR>

" yank file name to system clipboard (\cfn)
nnoremap <leader>cfn :let @+=expand("%:t")<CR>
