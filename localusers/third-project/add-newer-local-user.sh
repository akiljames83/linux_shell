#!/bin/bash

# Ensure that the user is root for them to run the script
if [[ "${UID}" -ne 0 ]]
then
  echo "Must be root to access this program." >&2 # send to STDERR
  exit 1;
fi

# Ensure the correct amount of command line arguments are provided
if [[ "$#" = 0 ]]
then
  echo "Usage: USER_NAME [COMMENT]..." >&2
  exit 1;
fi

# Use the frist argument provided on command line as username for account
USERNAME=${1}
shift
COMMENT="$*"

# Generate password for the user
S='!@#$%^&*()_+-='
R_CHAR=`echo $S | fold -w1 | shuf | head -c1`
PASSWORD=`date +%s%N${RANDOM}${R_CHAR}${RANDOM} | sha256sum | head -c32`

# Creates the new user
useradd -m $USERNAME -c "$COMMENT" &> /dev/null

# Check to see if the user was not able to be created
if [[ "$?" -ne 0 ]]
then
  echo "User was not able to be created." >&2
  exit 1;
fi

# Add password to the user
echo "${PASSWORD}${R_CHAR}" | passwd --stdin $USERNAME &> /dev/null

# Check if there was an error in creating the users password
if [[ "$?" -ne 0 ]]
then
  echo "Could not set user password." >&2
  exit 1;
fi

# Display the username, password and host
echo 
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Host: ${HOSTNAME}"
echo

# exit code with 0 for successful program
exit 0;


