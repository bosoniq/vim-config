# Vim Config
Vim php setup. Includes plugins, configurations and snippets


# Build vimrc

Configuration options are found in the `config` directory with one file per plugin. Files are concatenated using the build-vimrc script. 

    ./build-vimrc
    
Running this script will create a `build/vimrc` file which will be the final vimrc file loaded by vim

# Loading vimrc
To load the configuration add the following lines to your `~/.vimrc` or `~/.config/nvim/init.vim` file:

    let $CONFIGDIR='~/path/to/your/vim-config'  
    execute 'source ' . $CONFIGDIR . '/init.vim'
