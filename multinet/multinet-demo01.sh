#!/bin/bash

# Create a script to determine if the other servers in the network are up

# 1. Initialize the file of servers
LOC_SERVERS='/vagrant/servers'

# 2. Check if the file provided is valid
if [[ ! -e "$LOC_SERVERS" ]]
then
  echo "File does not exist." >&2
  exit 1;
fi

# 3. Loop through the servers
for SERVER in $(cat $LOC_SERVERS)
do
  ping -c 1 $SERVER &> /dev/null
  if [[ "$?" -ne 0 ]]
  then
    echo "$SERVER is down."
  else
    echo "$SERVER is connected."
  fi
done

exit 0;
