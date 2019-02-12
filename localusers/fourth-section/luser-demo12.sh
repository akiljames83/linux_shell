#!/bin/bash

# Parsing Command Line Options with getopts
# This script generates a random password
# They use can set password length w -l and add a special character -s
# Verbose mode can be enabled with -v

# Define a usage function for user
function usage {
  echo "Usage ${0}: [-vs] [-l LENGTH]" >&2
  echo 'Generate a random password.'
  echo '  -l LENGTH Specify password length.'
  echo '  -s        Add special character to password.'
  echo '  -v        Enable the verbose mode.'
  exit 1;
}

# Set a default password Length
LENGTH=48

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
