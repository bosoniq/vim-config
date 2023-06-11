#!/usr/bin/env bash

# read/write options
BUILD=./build
CONFIGS=./config
VIMRC=${BUILD}/vimrc
COCSETTINGS=${BUILD}/coc-settings.json
LUANAMESPACE=bosoniq

# prepare vimrc for writing
if [ ! -d "$BUILD" ]; then
    mkdir ${BUILD}
    touch ${VIMRC}
    touch ${COCSETTINGS}
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

