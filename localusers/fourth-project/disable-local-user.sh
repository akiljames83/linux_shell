#!/bin/bash

# Script to disable, delete and/or archive a local Linux account

# 1. Check if the user is ROOT
if [[ "$UID" -ne 0 ]]
then
  echo "Must be root or run with sudo to use script." >&2
  exit 1;
fi

# 2. Create a varios functions
# USAGE
function usage {
  echo "Usage ${0}: [-dra] ACCOUNT_NAME [ACCOUNT_NAME...]" >&2
  echo "  -d Deletes accounts instead of disabling them." >&2
  echo "  -r Removes the home directory associated with the account(s)." >&2
  echo "  -a Archives the directory of the account." >&2
  return 1;
}
# PERMISSION
function check_permission {
  local USER="$1"
  if [[ `id -u $USER` -le 999 ]]
  then
    return 1;
  else
    return 0;
  fi;
}

# DISABLE
function disable {
  local USER="${1}"
  if [[ `check_permission $USER` -eq 1 ]]
  then
    echo "Cannot modift admin accounts." >&2
    return 1;
  fi
  
}

# DELETE
function delete {
  local USER="${1}"
  if [[ `check_permission $USER` -eq 1 ]]
  then
    echo "Cannot modift admin accounts." >&2
    return 1;
  fi
  userdel $USER
  return $?
}

# REMOVE
function remove {
  local USER="${1}"
  if [[ `check_permission $USER` -eq 1 ]]
  then
    echo "Cannot modift admin accounts." >&2
    return 1;
  fi
  rmdir /home/$USER
  return $?
}

# ARCHIVE
function archive {
  local USER="${1}"
  if [[ `check_permission $USER` -eq 1 ]]
  then
    echo "Cannot modift admin accounts." >&2
    return 1;
  fi
  
  # Check if the /archive directory exists
  if [[ ! -d "/archive" ]]
  then 
    mkdir /archive
  fi

  # Archive the user file
  tar -cxf "/archive/${USER}_archive.tar" /home/$USER
  return $?
 
}
# 2. Initalize action variable.
#    1 -> Disable
#    2 -> Delete
#    3 -> Remove home directory of account
#    4 -> Creates archive of the account and stores in /archive, make if it dosent exist
ACTION='1'

# 4. Loop through the command line options
while getopts dra OPTION
do
  case $OPTION
    d)
      ACTION='2'
      ;;
    r)
      ACTION='3'
      ;;
    a)
      ACTION='4'
      ;;
    ?)
      usage
      exit $?
      ;;
  esac
done

# 6. Shift the command line options
shift $(( OPTIND - 1 ))

# 7. Check to see if bad info passed in
if [[ "$#" -eq 0 ]]
then
  usage
  exit $?
fi

for CUSER in "$@"
do
  case $ACTION
    1)
      echo "Disabling the user ${CUSER}."
      disable $CUSER
      ;;
    2)
      echo "Deleting the user ${CUSER}."
      delete $CUSER
      ;;
    3)
      echo "Removing home directory of ${CUSER}."
      remove $CUSER
      ;;
    4)
      echo "Archive home directory of ${CUSER}."
      archive $CUSER
      ;;
  esac
done

