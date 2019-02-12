#!/bin/bash

# Script to disable, delete and/or archive a local Linux account

# 1. Check if the user is ROOT
if [[ "$UID" -ne 0 ]]
then
  echo "Must be root or run with sudo to use script." >&2
  exit 1;
fi

# 2. Create USAGE function
function usage {
  echo "Usage ${0}: [-dra] ACCOUNT_NAME ..." >&2
  echo "  -d Deletes accounts instead of disabling them." >&2
  echo "  -r Removes the home directory associated with the account(s)." >&2
  echo "  -a Archives the directory of the account." >&2
  return 1;
}

# 4. Loop through the command line options
while getopts dra OPTION
do
  case $OPTION
    d) DELETE_USER='true';;
    r) REMOVE_DIR='-r';;
    a) ARCHIVE='true';;
    ?) usage; exit $? ;;
  esac
done

# 6. Shift the command line options
shift $(( OPTIND - 1 ))

# 7. Check to see if user passed in an account name
if [[ "$#" -eq 0 ]]
then
  usage
  exit $?
fi

for CUSER in "$@"
do
  echo "Processing user ${CUSER}."
  USERID=$((id -u CUSER))
  if [[ "${USERID}" -le 999 ]]
  then
    echo "Refusing to remove the ${CUSER} account with the UID ${USERID}." >&2
    exit 1;
  fi
  
  # Create an archive is requested to do so
  if [[ "$ARCHIVE" = "true" ]]
  then
    # Check if the /archive directory exists
    if [[ ! -d "/archive" ]]
    then
      echo "Making the /archive directory."
      mkdir -p "/archive"
      if [[ "$?" -ne 0 ]]
      then
        echo "The archive directory could not be created." >&2
        exit 1;
      fi
    fi
    
    # Archive the user's home directory and move it to the /archive directory
    HOME_DIR="/home/$CUSER"
    ARCH_FILE="/archive/${CUSER}.tgz"
    if [[ -d "$HOME_DIR" ]]
    then
      echo "Archiving ${CUSER}'s directory to ${ARCH_FILE}."
      tar -zcf $ARCH_FILE $HOME_DIR &> /dev/null
      if [[ "$?" -ne 0 ]]
      then
        echo "Could not create ${ARCH_FILE}." >&2
        exit 1;
      fi
    else
      echo "${HOME_DIR} does not exist." >&2
      exit 1;
    fi
  fi
  
  # Delete the user directory if required
  if [[ "$DELETE_USER" = 'true' ]]
  then
    # Delete the user
    echo "Deleting the user ${CUSER}."
    userdel $REMOVE_DIR $CUSER
    if [[ "$?" -ne 0 ]]
    then
      echo "The account ${CUSER} was not deleted." >&2
      exit 1;
    fi
    echo "The account of ${CUSER} was deleted."
  else
    # Else; Disable the users account
    chage -E 0 ${CUSER}
    if [[ "$?" -ne 0 ]]
    then
      echo "The account ${CUSER} was not disabled." >&2
      exit 1;
    fi
    echo "The account ${CUSER} was disabled."  
  fi
done

exit 0;
