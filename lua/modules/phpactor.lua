-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config['phpactor'] = {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        ["language_server_phpstan.bin"] = phpstan,
        ["language_server_completion.trim_leading_dollar"] = true,
        ["logging.level"] =  "debug",
        ["logging.path"] =  "phpactor.log",
        ["logging.enabled"] =  false,
    }
}


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    vim.keymap.set('n', 'gca', vim.lsp.buf.code_action, {})
    vim.keymap.set('n', 'gcm', function() vim.cmd('PhpactorContextMenu') end, {})
    vim.keymap.set('n', 'grn', vim.lsp.buf.rename, {silent = true})
    vim.keymap.set('n', 'gd', ':botright PhpactorGotoDefinition vsplit<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {silent = true})
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, {silent = true})
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, { noremap=true, silent=true })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, { noremap=true, silent=true })


    -- Format the current buffer on save
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({bufnr = args.buf, id = client.id})
      end,
    })

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '✘',
          [vim.diagnostic.severity.WARN] = '▲',
          [vim.diagnostic.severity.HINT] = '⚑',
          [vim.diagnostic.severity.INFO] = '»',
        },
      },
    })
  end,
})

-- time it takes to trigger the `CursorHold` event
vim.opt.updatetime = 500

local function highlight_symbol(event)
  local id = vim.tbl_get(event, 'data', 'client_id')
  local client = id and vim.lsp.get_client_by_id(id)
  if client == nil or not client.supports_method('textDocument/documentHighlight') then
    return
  end

  local group = vim.api.nvim_create_augroup('highlight_symbol', {clear = false})

  vim.api.nvim_clear_autocmds({buffer = event.buf, group = group})

  vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
    group = group,
    buffer = event.buf,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
    group = group,
    buffer = event.buf,
    callback = vim.lsp.buf.clear_references,
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Setup highlight symbol',
  callback = highlight_symbol,
})
