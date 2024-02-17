#!/usr/bin/with-contenv bash
# shellcheck shell=bash

if [[ -z "${BORG_RESTORE_ARCHIVE}" ]]
then
  echo "BORG_RESTORE_ARCHIVE environment variable not set, so no archives will be restored"
  exit
fi

if [borgmatic rlist | grep -q "${BORG_RESTORE_ARCHIVE}"]
then
  echo "${BORG_RESTORE_ARCHIVE} found, attempting to restore"
elif ["${BORG_RESTORE_ARCHIVE}" == "latest"]
  echo "attempting to restore latest archive"
else
  echo "Unknown error; exiting"
  exit
fi

# Extracting from the remote repo
mkdir -p /tmp/borg_restore

borgmatic extract --archive $BORG_RESTORE_ARCHIVE --destination /tmp/borg_restore
cp -r /tmp/borg_restore/* $BORG_SOURCE_DIRECTORY

# Clear the temp directory
#rm -rf /tmp/borg_restore
