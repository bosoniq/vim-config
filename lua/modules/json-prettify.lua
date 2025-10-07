-- Convert json to human readable
-- Convert json to human readable
vim.keymap.set('n', '+j', function()
  -- Save the current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  -- Run the external formatter
  vim.cmd('silent !npx prettier --write ' .. vim.fn.expand('%'))

  -- Reload the buffer from the disk to see the changes
  vim.cmd('edit!')

  -- Restore the cursor position
  vim.api.nvim_win_set_cursor(0, cursor_pos)

  print('Formatted with Prettier')
end, { desc = 'Format file with Prettier' })
