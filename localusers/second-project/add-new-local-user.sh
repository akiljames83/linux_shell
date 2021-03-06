#!/bin/bash
#
# This script creates a new user on the local system.
# You must supply a username as an argument to the script.
# Optionally, you can also provide a comment for the account as an argument

# Ensure script is executed by root
if [[ "${UID}" -ne 0 ]]
then
  echo "Script can only be run as root."
  exit 1
fi

# Checks if command line has greater than 1 argument
if [[ "${#}" = 0 ]]
then
  echo "Usage `basename ${0}`: USER_NAME [COMMENT]..."
  exit 1
fi

# Creates the new user with the first argument
USER_NAME=$1
shift
COMMENT="$*"
useradd -c "${COMMENT}" -m ${USER_NAME}

if [[ "$?" -ne 0 ]]
then
  echo "Account was not able to be created."
  exit 1
fi

# Generate password for the account
SPECIAL='!@#$%^&*()_+-='
R_CHAR=`echo "${SPECIAL}" | fold -w1 | shuf | head -c1`
PASSWORD=`date +%s%N${RANDOM}${R_CHAR}${RANDOM} | sha256sum | head -c16`

# Add password to user
echo "${PASSWORD}${R_CHAR}" | passwd --stdin ${USER_NAME}

if [[ "$?" -ne 0 ]]
then
  echo "Password was not able to be added."
  exit 1
fi

# Set the expiry for the passowrd
passwd -e ${USER_NAME}

# Display the user information
echo
echo "Username: ${USER_NAME}"
echo "Comments: ${COMMENT}"
echo "Password: ${PASSWORD}${R_CHAR}"
echo "Host: ${HOSTNAME}"
exit 0
