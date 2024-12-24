require'lspconfig'.intelephense.setup{
    init_options = {
      cmd = { 'intelephense', '--stdio' },
      filetypes = { 'php' },
      root_markers = { 'composer.json', 'composer.lock' },
    },
    settings = {
      intelephense = {
        files = {
          maxSize = 1000000;
        };
      };
    }
}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client:supports_method('textDocument/codeAction') then
      vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, {})
    end

    if client:supports_method('textDocument/rename') then
      vim.keymap.set('n', 'grn', vim.lsp.buf.rename, {silent = true})
    end

    if client:supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {silent = true})
    end

    if client:supports_method('textDocument/references') then
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, {silent = true})
    end

    if client:supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {silent = true})
    end

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
      -- vim.keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.completion.trigger()<cr>')
    end

    if client:supports_method('textDocument/formatting') then
      -- Format the current buffer on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({bufnr = args.buf, id = client.id})
        end,
      })
    end

    if client:supports_method('textDocument/signatureHelp') then
       vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, { noremap=true, silent=true })
    end

    -- not currently supported
    if client:supports_method('textDocument/inlayHint') then
        vim.lsp.inlay_hint.enable(true, {bufnr = args.buf})
    end

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
