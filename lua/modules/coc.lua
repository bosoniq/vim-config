vim.opt.updatetime = 1000

vim.g.coc_global_extensions = {
    '@yaegassy/coc-intelephense',
    'coc-json',
    'coc-spell-checker',
    'coc-phpls',
    'coc-snippets',
    '@yaegassy/coc-phpstan'
}

vim.keymap.set('n', '<leader>a',  '<Plug>(coc-codeaction-cursor)', {silent = true})
vim.keymap.set('n', '<leader>ga', '<Plug>(coc-codeaction-line)', {silent = true})
vim.keymap.set('n', '<leader>re', '<Plug>(coc-codeaction-refactor)', {silent = true})

-- GoTo code navigation
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', {silent = true})
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', {silent = true})
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', {silent = true})
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', {silent = true})

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- Formatting selected code
vim.keymap.set({'n', 'x'}, '<leader>f',  '<Plug>(coc-format-selected)')

vim.keymap.set('i', '<c-space>', vim.fn['coc#refresh'], {silent = true, expr = true})

-- Symbol renaming
vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)')

-- Remap keys for applying refactor code actions
vim.keymap.set('n', '<leader>re', '<Plug>(coc-codeaction-refactor)', {silent = true})
vim.keymap.set({'n', 'x'}, '<leader>r', '<Plug>(coc-codeaction-refactor-selected)', {silent = true})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- Add `:OR` command for organize imports of the current buffer (Not with intelephense)
-- vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

vim.keymap.set('', '<F6>', '<Cmd>Fold<cr>')
vim.keymap.set('', '<F7>', 'zE')
vim.keymap.set('', '<F2>', '<Cmd>Format<cr>')

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics
vim.keymap.set("n", "<space>d", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
vim.keymap.set("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
vim.keymap.set("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document
vim.keymap.set("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
vim.keymap.set("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item
vim.keymap.set("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
vim.keymap.set("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
vim.keymap.set("n", "<space>p", ":<C-u>CocListResume<cr>", opts)

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}

-- confirm completion
vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
-- cycle options downwards
vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
-- cycle options upwards
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

vim.keymap.set('n', '<leader>cl', '<Plug>(coc-codelens-action)', {silent = true})
