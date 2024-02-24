vim.g.nuuid_no_mappings = 1

vim.keymap.set(
    'n', '<Leader>u',
    function ()
      vim.fn.PhpInsertUse()
      vim.fn.feedkeys('a', 'n')
    end
)

vim.keymap.set(
    'n', '<Leader>s',
    function ()
        vim.fn.PhpSortUse()
    end
)

vim.keymap.set(
    'n', '<Leader>x',
    function ()
      vim.fn.PhpExpandClass()
      vim.fn.feedkeys('a', 'n')
    end
)
