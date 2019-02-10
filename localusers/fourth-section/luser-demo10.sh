#!/bin/bash

# Using functions in bash

# First method
function log1 {
  echo "First way to make a function"
}

# Second method
log2() {
  echo "Second way to make a function"
}

# A function must be defined above before it can be called
# Call the functions
log1
log2


# New shell builtin local, allows one to take the parameters for a bash function
# local variables cannot be accessed outside of the function
function log {
  local MESSAGE="$*"
  echo $MESSAGE
}

# log this is a string of arguments
# log 'hello there'

# Constants in bash
readonly VERBOSE='true'
better_log() {
  local MESSAGE="${*}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

better_log A new message with better log

#readonly VERBOSE='true'
better_log_2() {
  # If verbose is true, the system sends a message to command
  # line and to sys log. 
  # Sys log is displayed with : sudo tail /var/log/messages
  local MESSAGE="${*}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
  logger -t luser-demo10.sh "${MESSAGE}"
}

better_log_2 "Hello from ${0}!"
DISP_LOG=1
if [[ "${DISP_LOG}" = 1 && "${UID}" = 0 ]]
then
  tail /var/log/messages
fi




