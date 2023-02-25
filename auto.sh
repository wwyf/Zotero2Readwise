#!/bin/bash


# echo python run.py $READWISE_TOKEN $ZOTERO_KEY $ZOTERO_ID --version_number=12799

python run.py $READWISE_TOKEN $ZOTERO_KEY $ZOTERO_ID --version_number=12799 >> /tmp/readwise.log 2>&1

tail -n 1 /tmp/readwise.log > ./zotero_version_number

cat ./zotero_version_number