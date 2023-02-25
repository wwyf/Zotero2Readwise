#!/bin/bash


# echo python run.py $READWISE_TOKEN $ZOTERO_KEY $ZOTERO_ID --version_number=12799


READWISE_TOKEN=$1
ZOTERO_KEY=$2
ZOTERO_ID=$3

python run.py $READWISE_TOKEN $ZOTERO_KEY $ZOTERO_ID --version_number=12799 >> /tmp/readwise.log 2>&1

tail -n 1 /tmp/readwise.log > ./zotero_version_number

cat ./zotero_version_number