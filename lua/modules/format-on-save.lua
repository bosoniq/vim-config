local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

format_on_save.setup({
  exclude_path_patterns = {
    "/vendor/",
  },
  formatter_by_ft = {
    php = formatters.lsp,
    json = formatters.prettierd,
    markdown = formatters.prettierd,
    yaml = formatters.prettierd,
  },
  fallback_formatter = {
    formatters.remove_trailing_whitespace,
    formatters.remove_trailing_newlines,
  }
})
