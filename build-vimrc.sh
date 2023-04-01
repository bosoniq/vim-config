#!/usr/bin/env bash

# read/write options
DIR=./build
FILE=${DIR}/vimrc
CONFIGS=./config

# prepare vimrc for writing
if [ ! -d "$DIR" ]; then
    mkdir ${DIR}
    touch ${FILE}
else 
    if [ -f "$FILE" ]; then
        rm ${FILE}
    fi

    touch ${FILE}
fi

# concat config file contents to build/vimrc
for CONFIG in ${CONFIGS}/*; do less $CONFIG >> $FILE; done

# create coc settings file
cp -v coc-settings.json ${HOME}/.config/nvim/coc-settings.json

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


