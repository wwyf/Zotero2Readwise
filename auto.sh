#!/bin/bash


# echo python run.py $READWISE_TOKEN $ZOTERO_KEY $ZOTERO_ID --version_number=12799


READWISE_TOKEN=$1
ZOTERO_KEY=$2
ZOTERO_ID=$3

VERSION_NUMBER=$(cat ./zotero_version_number)

python run.py $READWISE_TOKEN $ZOTERO_KEY $ZOTERO_ID --version_number=${VERSION_NUMBER} >> /tmp/readwise.log 2>&1

cat /tmp/readwise.log

tail -n 1 /tmp/readwise.log > ./zotero_version_number

cat ./zotero_version_number