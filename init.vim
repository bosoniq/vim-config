let phpcs='phpcs' 
let phpmd='phpmd'

"Import plugins
let $PLUGINS = $CONFIGDIR . '/plugins'
execute 'source ' . $PLUGINS

"Import main configuration
let $CONFIG = $CONFIGDIR . '/build/vimrc'
execute 'source ' . $CONFIG
