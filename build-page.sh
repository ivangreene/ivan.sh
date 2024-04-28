#!/usr/bin/env bash

FILE=$1
PAGE=$(echo $FILE | sed -e 's/\.md$//' -e 's#pages/##')
META=$(echo $FILE | sed -e 's/\.md$/.json/')

if [ "$PAGE" != "index" ]; then
    REDIRECT_DIR=pub/$PAGE
    mkdir -p $REDIRECT_DIR
    jinja2 redirect.html -D page=$PAGE $META --format=json > $REDIRECT_DIR/index.html
fi

OUTFILE=pub/$PAGE.html

jinja2 top.html $META --format=json > $OUTFILE
markdown $FILE >> $OUTFILE
cat bottom.html >> $OUTFILE
