#!/bin/bash

# This script generates a random passowrd for each user specified on the command line.

# Dislay what the user typed on the command line
echo "You executed this command: ${0}"

# Display path and filename of the script
echo "Filename: $(basename $0)"
echo "Path: $(dirname $0)"

# Tell how many arguments they passed into the program
# (inside the script - arguments, outside - parameters)
NUMBER_OF_PARAMS="${#}"
echo "You supplied ${NUMBER_OF_PARAMS} argument(s) on the command line"

# Make sure they at least supply one argument
if [[ "${NUMBER_OF_PARAMS}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [USER_NAME]..."
  exit 1;
fi

# Generate and display a password for each parameter
S='!@#$%^&*()_+-='
for USERNAME in $@;
do
  SPECIAL=$( echo $S | fold -w1 | shuf | head -c1 )
  PASSWORD=$( date +%s%N{RANDOM}{RANDOM}{SPECIAL} | sha256sum | head -c32)
  echo "USER: ${USERNAME}, PASSWORD: ${PASSWORD}"
done

