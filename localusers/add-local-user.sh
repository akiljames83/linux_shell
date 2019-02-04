#!/bin/bash

USER=${UID}
ROOT=0

# Check if user is root
if [[ "${USER}" -ne "${ROOT}" ]]
then
  echo "Must be root user to run script."
  exit 1;
fi

# Get the username (LOGIN)
read -p "Enter username: " LOGIN

# Get name of person (COMMENT)
read -p "Enter full name of new user: " COMMENT

# Get initial passowrd
read -p "Enter initial password: " PASSWORD

# Creat new user
useradd -c "${COMMENT}" -m ${LOGIN}

if [[ "$?" != 0 ]]
then
  echo "The account was not able to be created."
  exit 1;
fi

echo ${PASSWORD} | passwd --stdin ${LOGIN}
passwd -e ${LOGIN}

if [[ "$?" != 0 ]]
then
  echo "The account was not able to be created."
  exit 1;
fi

# Display the user information
echo "Username is : ${LOGIN}"
echo "Password is: ${PASSWORD}"
echo "Host is : ${LOGIN}"

