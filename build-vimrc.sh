#!/usr/bin/env bash

# read/write options
LUANAMESPACE=als56gh

# build directories and files
BUILD="${PWD}/build"
CONFIGS="${PWD}/config"
INIT=${BUILD}/init.vim
LUAMAIN="${BUILD}//lua//main.lua"
VIMRC=${BUILD}/vimrc
COCSETTINGS=${BUILD}/coc-settings.json
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
touch ${COCSETTINGS}
touch ${INIT}
touch ${LUAMAIN}

# concat config file contents to build/vimrc
for CONFIG in ${CONFIGS}/*; do less $CONFIG >> $VIMRC; done

# prepare init.vim
initVim=$(<init.vim)
initVim="${initVim//CONFIGDIR/$PWD}"
echo "$initVim" > ${INIT}

# create coc settings file
cocSettings=$(<coc-settings.json)
cocSettings="${cocSettings//CONFIGDIR/$PWD}"
echo "$cocSettings" > ${COCSETTINGS}

# copy and update lua modules
main=$(<lua/main.lua)
main="${main//NAMESPACE/$LUANAMESPACE}"
echo "$main" >> $VIMRC
cp -R ${PWD}/lua/modules/. ${LUAMODULES}

# create symbolic links
echo -e "\nCreating symbolic links ...."
ln -s ${INIT} ~/.config/nvim/init.vim
ln -s ${COCSETTINGS} ~/.config/nvim/coc-settings.json
ln -s ${BUILD}/lua ~/.config/nvim/lua

# composer dependency installation/update
composer -v > /dev/null 2>&1
COMPOSER=$?
if [[ $COMPOSER -ne 0 ]]; then
    echo -e "\nComposer is not installed"
else

    if [ -d "./vendor" ] 
    then
        echo -e "\nUpdating composer libraries ...."
        composer update
    else
        echo -e "\nInstalling composer libraries ...."
        composer install
    fi
fi

