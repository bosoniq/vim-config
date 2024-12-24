require'lspconfig'.phpactor.setup{
    on_attach = on_attach,
    init_options = {
        ["language_server_phpstan.bin"] = phpstan,
        ["language_server_phpstan.level"] = 9,
        ["language_server_phpstan.enabled"] = true,
        ["language_server_completion.trim_leading_dollar"] = true,
        ["php_code_sniffer.bin"] = phpcs,
        ["php_code_sniffer.enabled"] = true,
        ["symfony.enabled"] = true,
        ["logging.level"] =  "debug",
        ["logging.path"] =  "phpactor.log",
        ["logging.enabled"] =  false,
    }
}
