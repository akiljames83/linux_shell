#!/bin/bash

# This scrit demonstrates I/O redirection

# Redirect STDOUT to a file.
FILE='file'
head -n2 /etc/passwd > ${FILE}

# Redirect STDIN to a program.
read LINE < ${FILE}
echo "LINE variable now contains: $LINE"

# Redirecr STDOUT to a file, overwriting the file
head -n4 /etc/passwd > ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# Redirect STDOUT to a file appending to file
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo
echo "Contents of ${FILE}:"
cat $FILE


