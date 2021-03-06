#!/bin/bash

# Parsing Command Line Options with getopts
# This script generates a random password
# They use can set password length w -l and add a special character -s
# Verbose mode can be enabled with -v

# Define a usage function for user
# Model usage page as that specified in man pages.
function usage {
  echo "Usage ${0}: [-vs] [-l LENGTH]" >&2
  echo 'Generate a random password.'
  echo '  -l LENGTH Specify password length.'
  echo '  -s        Add special character to password.'
  echo '  -v        Enable the verbose mode.'
  exit 1;
}

# Implement a function to display things if verbosity is set
function log {
  if [[ "$VERBOSE" = 'true' ]]
  then
    echo "$*"
  fi
}

# Set a default password Length
LENGTH=48
VERBOSE='false'
# The colon after an argument specifies that it must be followed by a value
while getopts vl:s OPTION
do
  case ${OPTION} in
    v)
      VERBOSE='true'
      echo 'Verbose mode on.'
      ;;
    l)
      # Get ops places required arguments into shell variable OPTARG
      LENGTH="${OPTARG}"
      ;;
    s)
      USE_SPECIAL_CHAR='true'
      ;;
    ?) # This is for a single character not specified
      usage
      exit 1;
      ;;
  esac # Backwards case ends the case statement
done

# Check to see if there are extra arguments
shift "$(( OPTIND -1 ))"
if [[ "$#" -ne 0 ]]
then
  usage
  exit $?;
fi

# Generate a password
log 'Generating a password.'
PASSWORD=`date +%s%N${RANDOM} | sha256sum | head -c $LENGTH`

# Add random character if specified
if [[ "$USE_SPECIAL_CHAR" = 'true' ]]
then
  log 'Adding random character.'
  S='!@#$%^&*()_+-='
  R_CHAR=`echo "$S" | fold -w1 | shuf | head -c1`
  PASSWORD="${PASSWORD}${R_CHAR}"
fi

log 'Password completed.'
log 'Here is the password:'

# Display the password
echo $PASSWORD

log ''
log 'Exiting program.'
exit 0

