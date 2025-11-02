require("conform").setup({
  formatters = {
    phpcbf = {
      command = vim.fn.expand("~/.composer/vendor/bin/phpcbf"),
      args = { "--standard=PSR12", "$FILENAME" },
    },
    prettier = {
      command = vim.fn.expand("~/bin/node-v20.18.0-linux-x64/bin/prettier"),
      args = { "--stdin-filepath", "$FILENAME" },
      stdin = true,
    },
  },
  formatters_by_ft = {
    php = { "phpcbf",  lsp_format = "fallback" },
    json = { "prettier" },
    markdown = { "prettier" }
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
