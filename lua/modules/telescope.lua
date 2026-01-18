local telescope = require('telescope')

telescope.setup{
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

-- Load extensions.
telescope.load_extension('recent_files')
telescope.load_extension('harpoon')
telescope.load_extension('bookmarks')
telescope.load_extension('cmdline')
telescope.load_extension('fzf')

-- Map a shortcut to open the picker.
vim.api.nvim_set_keymap("n", "<leader>fr",
  [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
  {noremap = true, silent = true})


vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fc', '<cmd>Telescope cmdline<cr>')

-- Disable folding in Telescope's results preview window.
vim.api.nvim_create_autocmd("User", { pattern = "TelescopePreviewerLoaded", command = [[setlocal nofoldenable]] })
