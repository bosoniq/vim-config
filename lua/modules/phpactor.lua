require'lspconfig'.phpactor.setup{
    on_attach = on_attach,
    init_options = {
        ["phpstan.level"] = 9,
        ["language_server_phpstan.bin"] = phpstan,
        ["language_server_completion.trim_leading_dollar"] = true,
        ["logging.level"] =  "debug",
        ["logging.path"] =  "phpactor.log",
        ["logging.enabled"] =  false,
    }
}
