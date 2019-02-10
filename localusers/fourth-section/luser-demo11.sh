#!/bin/bash

SCRIPT=${0}
VERBOSE='true'
function log {
  # Function to log information
  local MSG="$*"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "$MSG"
  fi
  logger -t $SCRIPT "$MSG"
}

# Develop function to backup files
backup_file() {
  # Backs up a file. Returns non-zero status on error.
  
  # Store file in local var
  local FILE="${1}"

  # Check if file exists
  if [[ -f "$FILE" ]]
  then
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    log "Backing up ${FILE} to ${BACKUP_FILE}."

    # Exit status is return value of cp command
    cp -p $FILE $BACKUP_FILE
    return $?
  else
    log "Failed Backup: ${FILE} does not exist." 
    return 1;
  fi
}


backup_file /etc/passwd

if [[ $? -eq 0 ]]
then
  log "File backup succeeded!"
else
  log "File backup failed!"
  exit 1;
fi
