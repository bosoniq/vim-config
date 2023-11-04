local telescope = require('telescope')

telescope.setup{}

-- Load extensions.
telescope.load_extension('recent_files')

-- Map a shortcut to open the picker.
vim.api.nvim_set_keymap("n", "<leader>fr",
  [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
  {noremap = true, silent = true})
