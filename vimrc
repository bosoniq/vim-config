"pff Vim settings syntax on
" :set guifont=Fira\ Code\ 11
" set guifont=DeJaVu\ Sans\ Mono\ 11
" :set guifont=Noto\ Sans\ 10

" set relativenumber
set number
set hlsearch
set autoread | au CursorHold * checktime | call feedkeys("lh")
set foldlevel=1
set hidden
let NERDTreeShowHidden=1

filetype plugin on
let g:DisableAutoPHPFolding = 1
map <F6> <Esc>:EnableFastPHPFolds<Cr>
map <F7> <Esc>:EnablePHPFolds<Cr>
map <F8> <Esc>:DisablePHPFolds<Cr>


filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" set line char guide
set colorcolumn=120


" Auto-close brackets
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O 

"""""""""""""""
"" Yank mods ""
"""""""""""""""
" yank relative path to system clipboard (\crp)
nnoremap <leader>crp :let @+=expand("%")<CR>

" yank file name to system clipboard (\cfn)
nnoremap <leader>cfn :let @+=expand("%:t")<CR>


filetype plugin on

" Auto complete enhancement
set completeopt=longest,menuone

" Search is now case insensitive by defaut
set ignorecase


"""PHPQA -  :Php, :Phpcs, :Phpmd, :Phpcc
" PHP Code Sniffer binary (default = "phpcs")
let g:phpqa_codesniffer_cmd=phpcs
let g:phpqa_codesniffer_args = "--standard=PSR2 -n"
let g:phpqa_codesniffer_autorun = 1

" PHP Mess Detector binary (default = "phpmd")
let g:phpqa_messdetector_cmd=phpmd
let g:phpqa_messdetector_autorun = 0

" Stop the location list opening automatically
let g:phpqa_open_loc = 1


"Ctrlp settings
set wildignore+=*/.git/*,*/.DS_Store,*/vendor/*,*/node_modules/*,*/www/*,*/templates/*,*/docker-*/*,*/dockerphp/*,*/volumes/*,*/app/*/tmp/*,*/tests/_data/*,*/tests/_output/*,*/tests/_support/*,*/tests/acceptance/*,*.jpg,*.jpeg,*.png,*.js,*.jsx,*.snap,*.css

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("t")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("e")': ['<cr>'],
    \ } "Open file in new buffer


set laststatus=2


""""""""""""""""""""""""
"""" Lightline setup """
""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'gitbranch', 'session' ] ]
      \ },
      \ 'component': {
      \   'session': '%{GetSessId(v:this_session)}',
      \   'gitbranch': '%{gitbranch#name()}'
      \ },
      \ }


function! GetSessId(string)
   let passedString = a:string
   if strlen(passedString) > 0
       let sessFileComponents = split(passedString, '/')
       return join(sessFileComponents[-2: -1], '/')
   endif
   return 'No Session'
endfunction

""""""""""""""""""""""""
""" Buftabline setup """
""""""""""""""""""""""""
let g:buftabline_numbers = 1


"""""""""""""""""""
""" Colorshceme """
"""""""""""""""""""
set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
colorscheme ayu


"""""""""""""""""""""""""""""
""" coc-snppets (default) """
"""""""""""""""""""""""""""""
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"   "confirm completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"        "cycle options downwards
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"    " cycle options upwards


"Key Mappings
nnoremap <silent> <C-k><C-b> :NERDTreeToggle<CR>
nnoremap <Space> za


" Convert json to human readable
nmap =j :%!python -m json.tool<CR>

