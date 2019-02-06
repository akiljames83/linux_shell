#!/bin/bash


# Display the UID and username of the user executing the script
# Display if the user is the root user or not

## TASKS

# Display the UID
echo "Your UID is ${UID}"

# Display the username
USER_NAME=`whoami`    # Option 1
USER_NAME_2=$(id -un) # Option 2

echo "Username is: ${USER_NAME}"

# Display if the user is root or not
if [[ "${UID}" -eq 0 ]]
then
	echo 'You are root.'
else 
	echo 'You are not root.'
fi
