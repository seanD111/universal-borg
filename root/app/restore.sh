#!/usr/bin/with-contenv bash
# shellcheck shell=bash

# Setting this, so the repo does not need to be given on the commandline:
# export BORG_REPO=ssh://username@example.com:2022/~/backup/main

# See the section "Passphrase notes" for more infos.
# export BORG_PASSPHRASE='XYZl0ngandsecurepa_55_phrasea&&123'

# We need an exact backup name
# export BORG_ARCHIVE='myserver-system-2019-08-11'

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Restore interrupted >&2; exit 2' INT TERM

info "Starting restore"
if [borg rlist | grep -q $BORG_ARCHIVE]
then
  # Extracting from the remote repo
  mkdir -p /tmp/borg_restore
  cd /tmp/borg_restore

  borg extract $BORG_ARCHIVE
  cp -r /tmp/borg_restore/* /config/
else
  info "Archive not found"
  false
fi

restore_exit=$?

if [ ${restore_exit} -eq 0 ]; then
    info "Restore finished successfully"
else
    info "Restore not finished successfully"
fi

exit ${restore_exit}
