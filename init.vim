let phpcs='CONFIGDIR/vendor/bin/phpcs' 
let phpmd='CONFIGDIR/vendor/bin/phpmd'
let phpstan='CONFIGDIR/vendor/bin/phpstan' 

"Import plugins
let $PLUGINS = 'CONFIGDIR/plugins'
execute 'source ' . $PLUGINS

"Import main configuration
let $CONFIG = 'CONFIGDIR/build/vimrc'
execute 'source ' . $CONFIG
