#!/bin/bash

# Goal: Script that will run a command on multiple servers

# 1. Check if server file can be accessed.
SERVER_LOC='/vagrant/servers'

# PREAMBLE
function usage {
  echo "Usage ${0}: [-nsv] [-f FILE] COMMAND" >&2
  echo "Executes COMMAND on every remote system." >&2;
  echo "  -f FILE Specify the servers to be used." >&2
  echo "  -n      Dry run of program - commands dont execute." >&2
  echo "  -s      Run commands as sudo." >&2
  echo "  -v      Turn verbosity on." >&2
  exit 1;
}

# Function to display if verbose is enabled
function disp {
  if [[ "$VERBOSE" = 'true' ]]
  then
    echo "$1"
  fi
}

# Parse the command line options
while getopts f:nsv COMMAND
do
  case $COMMAND in
    f) SERVER_LOC=$1 ;;
    n) DRY_RUN='true' ;;
    s) SUDO="sudo" ;;
    v) VERBOSE='true' ;;
  esac
done

shift $(( OPTIND - 1 ))
COMMAND="$*"

# Ensure the user isnt ROOT
if [[ "$UID" = 0 ]]
then
  echo "Cannot be root." >&2
  usage
fi

if [[ ! -e "$SERVER_LOC" ]]
then
  echo "File cannot be accessed." >&2
  exit 1;
fi

# 2. Begin the loop through the list of the servers
for SERVER in $(cat $SERVER_LOC)
do
  # 3. SSH into the individual servers
  FRONT="ssh -o ConnectTimeout=2 $SERVER"

  # 4. If verbosity is enabled, display server
  disp $SERVER

  # 5. If dry run is enabled, dont run command, otherwise do.
  if [[ "$DRY_RUN" != 'true' ]]
  then
    $SUDO $FRONT $COMMAND
  else
    echo "DR: $SUDO $FRONT $COMMAND"
  fi
 
done

exit 0;

