#!/bin/bash

# Simple script to delete a user

# Check if the user is root
if [[ "${UID}" -ne 0 ]]
then
  echo "Must be root or run with sudo to use script." >&2
  exit 1;
fi

# Assume first arg is username
USER="$1"

# delete the user
userdel $USER

# check if deletion was successful
if [[ "$?" -ne 0 ]]
then
  echo "The user $USER was NOT deleted."
  exit 1;
else
  echo "The use $USER WAS deleted."
fi

