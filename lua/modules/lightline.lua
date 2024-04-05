vim.g.lightline = {
  colorscheme = 'powerline',
  active = {
    left = {
        { 'mode', 'paste' },
        { 'readonly', 'filename', 'gitbranch', 'session' }
    }
  },
  component = {
    session = '%{GetSessId()}',
    gitbranch = '%{gitbranch#name()}',
  },
  separator = { left = '|', right = '|' },
  subseparator = { left = '|', right = '|' }
}
