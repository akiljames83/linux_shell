#!/bin/bash

# This script demonstrates the case statement

#if [[ "${1}" = 'start' ]]
#then
#  echo "Starting"
#elif [[ "${1}" = 'stop' ]]
#then
#  echo "Stoping"
#else
#  echo 'Supply a valid option.' >&2
#  exit 1;
#fi
#

# Now do the same thing with case statements
case "$1" in
  start)
    echo 'Starting'
    ;;
  stop)
    echo 'Stopping'
    ;;
   status|state)
    echo 'Status'
    ;;
   *)
    echo 'Supply a valid input.' >&2
    exit 1;
    ;;
esac

