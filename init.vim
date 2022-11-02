let phpcs='phpcs' 
let phpmd='phpmd'

"Import main configuration
let $PLUGINS = $CONFIGDIR . '/vim-config/plugins'
execute 'source ' . $PLUGINS

"Import main configuration
let $CONFIG = $CONFIGDIR . '/vim-config/vimrc'
execute 'source ' . $CONFIG
