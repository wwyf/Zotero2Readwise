#!/bin/bash


# echo python run.py $READWISE_TOKEN $ZOTERO_KEY $ZOTERO_ID --version_number=12799


READWISE_TOKEN=$1
ZOTERO_KEY=$2
ZOTERO_ID=$3

echo old version number
cat ./zotero_version_number
VERSION_NUMBER=$(cat ./zotero_version_number)

python run.py $READWISE_TOKEN $ZOTERO_KEY $ZOTERO_ID --version_number=${VERSION_NUMBER} >> /tmp/readwise.log 2>&1

cat /tmp/readwise.log

log_tail=`tail -n 1 /tmp/readwise.log`

echo $log_tail

re='^[0-9]+$'
if ! [[ $log_tail =~ $re ]] ; then
   echo "error: Not a number" >&2; exit 1
fi

tail -n 1 /tmp/readwise.log > ./zotero_version_number

echo new version number
cat ./zotero_version_number