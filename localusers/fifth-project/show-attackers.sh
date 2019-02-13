#!/bin/bash

# Create a shell script that displays the number of failed attemps by 
# IP address and location.

FILE="$1"

# Check if user passed in a file
if [[ ! -e $FILE ]]
then
  echo "A file must be provided."
  exit 1;
fi

# echo "$FILE"
echo "CSV FILE:"
echo "COUNT,IP,LOCATION"
# Script to process info:
# Display, count, IP, location
cat "${FILE}" | grep -E "Failed "| awk -F "from " '{print $2}'\
| awk -F " port" '{print $1}'| sort -rn | uniq -c | sort -n | \
while read COUNT IP
do
  if [[ "$COUNT" -ge 10 ]]
  then
    LOCATION=`geoiplookup $IP | awk -F ", " '{print $2}'`
    echo "${COUNT},${IP},${LOCATION}"
  fi
done
