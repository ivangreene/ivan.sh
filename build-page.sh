#!/usr/bin/env bash

FILE=$1
PAGE=$(echo $FILE | sed -e 's/\.md$//' -e 's#pages/##')
META=$(echo $FILE | sed -e 's/\.md$/.json/')

OUTDIR=pub
OPTS=""
if [ "$PAGE" != "index" ]; then
    OPTS="-D asset_path=../"
    OUTDIR=$OUTDIR/$PAGE
fi

mkdir -p $OUTDIR
OUTFILE=$OUTDIR/index.html

jinja2 top.html $OPTS $META --format=json > $OUTFILE
pandoc --preserve-tabs --from gfm --to html $FILE >> $OUTFILE
cat bottom.html >> $OUTFILE
