#!/bin/bash

: ${BACKUP_SUFFIX:=.$(date '+%d')}
readonly tarball=$BACKUP_NAME$BACKUP_SUFFIX.tar.gz

# Create bucket, if it doesn't already exist
BUCKET_EXIST=$(aws s3 ls | grep $S3_BUCKET_NAME | wc -l)
if [ $BUCKET_EXIST -eq 0 ]; then
  aws s3 mb s3://$S3_BUCKET_NAME
fi

# tar and send to s3 without writing it all out to disk.
tar cz $BACKUP_TAR_OPTION $PATHS_TO_BACKUP | aws s3 cp --storage-class STANDARD_IA - s3://$S3_BUCKET_NAME/$tarball
