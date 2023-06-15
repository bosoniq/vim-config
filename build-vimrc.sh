#!/usr/bin/env bash

# read/write options
BUILD=./build
CONFIGS=./config
LUANAMESPACE=als56gh
VIMRC=${BUILD}/vimrc
COCSETTINGS=${BUILD}/coc-settings.json
LUAMODULES=${BUILD}/lua/${LUANAMESPACE}/

# prepare vimrc for writing
if [ ! -d "$BUILD" ]; then
    mkdir ${BUILD}
    touch ${VIMRC}
    touch ${COCSETTINGS}
    mkdir "${BUILD}//lua/"
    touch "${BUILD}//lua//main.lua"
    mkdir ${LUAMODULES}
else 
    if [ -f "$VIMRC" ]; then
        rm ${VIMRC}
        rm ${COCSETTINGS}
    fi

    touch ${VIMRC}
    touch ${COCSETTINGS}
fi

# concat config file contents to build/vimrc
for CONFIG in ${CONFIGS}/*; do less $CONFIG >> $VIMRC; done

# create coc settings file
cocSettings=$(<coc-settings.json)
cocSettings="${cocSettings//CONFIGDIR/$PWD}"
echo "$cocSettings" > ${COCSETTINGS}
ln -s ${PWD}/${COCSETTINGS} ~/.config/nvim/coc-settings.json

# copy and update lua modules
main=$(<lua/main.lua)
main="${main//NAMESPACE/$LUANAMESPACE}"
echo "$main" >> $VIMRC
cp -R ${PWD}/lua/modules/. ${LUAMODULES}
ln -s ${PWD}/${BUILD}/lua ~/.config/nvim/lua

# composer dependency installation/update
composer -v > /dev/null 2>&1
COMPOSER=$?
if [[ $COMPOSER -ne 0 ]]; then
    echo 'Composer is not installed'
else

    if [ -d "./vendor" ] 
    then
        echo 'Updating composer libraries ....'
        composer update
    else
        echo 'Installing composer libraries ....'
        composer install
    fi
fi

