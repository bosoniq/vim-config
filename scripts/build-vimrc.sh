#!/usr/bin/env bash

# read/write options
LUANAMESPACE=als56gh

# build directories and files
BUILD="${PWD}/build"
CONFIGS="${PWD}/vim-native"
INIT=${BUILD}/init.vim
LUAMAIN="${BUILD}//lua//main.lua"
VIMRC=${BUILD}/vimrc
COMPOSERBIN=${PWD}/vendor/bin/
LUAMODULES=${BUILD}/lua/${LUANAMESPACE}/

# clean existing build
if [ -d "$BUILD" ]; then
    echo -e "\nRemoving symbolic links ...."
    rm -rv ~/.config/nvim/*

    echo -e "\nRemoving current build ...."
    rm -rv ${BUILD}/*
    rmdir ${BUILD}
fi

# create build docs and directories
mkdir ${BUILD}
mkdir "${BUILD}//lua/"
mkdir ${LUAMODULES}
touch ${VIMRC}
touch ${INIT}
touch ${LUAMAIN}

# concat config file contents to build/vimrc
for CONFIG in ${CONFIGS}/*; do less $CONFIG >> $VIMRC; done

# prepare init.vim
initVim=$(<init.vim)
initVim="${initVim//CONFIGDIR/$PWD}"
echo "$initVim" > ${INIT}

# copy and update lua modules
main=$(<lua/main.lua)
main="${main//NAMESPACE/$LUANAMESPACE}"
main="${main//COMPOSERBIN/$COMPOSERBIN}"
echo "$main" >> $VIMRC
cp -R ${PWD}/lua/modules/. ${LUAMODULES}

# Repalce NAMESPACE with LUANAMESPACE in all modules
find "${LUAMODULES}" -type f -exec sed -i "s|NAMESPACE|${LUANAMESPACE}|g" {} +

# create symbolic links
echo -e "\nCreating symbolic links ...."
ln -s ${INIT} ~/.config/nvim/init.vim
ln -s ${BUILD}/lua ~/.config/nvim/lua
if [ ! -d 'phpactor' ]; then
    ln -s ${PWD}/phpactor ~/.config/phpactor
fi
