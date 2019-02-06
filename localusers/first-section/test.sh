#!/bin/bash
COUNT=0
while read line
do
#COUNT=$((COUNT+1))
#if [ "${COUNT}" = "10" ]
#then
  echo $line
#fi
done < "file.txt"
