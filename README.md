# Vim Config
Vim php setup. Includes plugins, configurations and snippets


# Build vimrc

Configuration options are found in the `lua` directory with one file per plugin. A build dir is prepared and linked to using the build-vimrc.sh script.

    ./build-vimrc.sh

Running this script will:
 - create a `build/vimrc` file which will be the final vimrc file loaded by vim
 - create symbolic links
 - create a `build/lua/{your-namespace}/` folder, copy the contents of `lua/modules` and append `lua/main.lua` to the `build/vimrc` file applying the namespace specified in the build script
 - install Composer libs

# Loading vimrc
To load the configuration add the following lines to your `~/.vimrc` or `~/.config/nvim/init.vim` file:

    let $CONFIGDIR='~/path/to/your/vim-config'
    execute 'source ' . $CONFIGDIR . '/init.vim'

---

# Install plugins

Run `:PlugInstall`

# Install dependencies

Run `npm i prettier -g`

Download **Phpactor** and add it to your PATH


### Node

To keep things clean you can remap the node gloabl install directory to wherever you want with:
```
npm config set prefix "<desired folder path>"
```
As part of local set this is mapped to `~/Node/`

---

# Fresh installations
- check that `~/.config/nvim/init.vim` exists and create if necessary
- install composer, node and Phpactor
- apt-get install pip ripgrep fd-find
- run :checkhealth in neovim and follow the instructions for enabling features
- install a patched font from [NerdFonts](https://www.nerdfonts.com/font-downloads)
