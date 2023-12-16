#!/bin/bash


# echo python run.py $READWISE_TOKEN $ZOTERO_KEY $ZOTERO_ID --version_number=12799


READWISE_TOKEN=$1
ZOTERO_KEY=$2
ZOTERO_ID=$3

echo old version number
cat ./zotero_version_number
VERSION_NUMBER=$(cat ./zotero_version_number)

python3 run.py $READWISE_TOKEN $ZOTERO_KEY $ZOTERO_ID --version_number=${VERSION_NUMBER} 