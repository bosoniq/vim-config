-- Convert json to human readable
-- vim.keymap.set('n',  '=j', '<cmd>%!python -m json.tool<cr>')
vim.keymap.set('n', '=j', function() os.execute('python3 -m json.tool') end)
