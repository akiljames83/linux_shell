#!/bin/bash

# Display the UID and username of the user executing the script
# Display if the user is the vagrant user or not

# TODOS
# Display the UID
echo "User UID: ${UID}"

# Only display if the UID does NOT match 1000
UID_TO_TEST_FOR='1000'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
  echo "Your UID does not match ${UID_TO_TEST_FOR}."
  exit 1;
fi

# Display the username
USER_NAME=$(whoami)

# Test if the command succeeded
if [[ "$?" -ne 0 ]] # The $? returns the exit status of last run command
then
  echo "The whoami command did not execute properly."
  exit 1;
fi
echo "Your username is ${USER_NAME}."

# You can use a string test conditional
USER_NAME_TO_TEST_FOR='vagrant'
if [[ "$USER_NAME_TO_TEST_FOR" = "${USER_NAME}" ]]
then
  echo "Your username matches ${USER_NAME_TO_TEST_FOR}."
fi

# Test for != (not equal) for the string
if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST_FOR}" ]]
then
  echo "Your username does not match ${USER_NAME_TO_TEST_FOR}."
  exit 1;
fi

exit 0;

