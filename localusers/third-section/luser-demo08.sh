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

# USE EXPLICUT FILE DESCRIPTORS (FD) for redirection
# Redirect STDIN to a program, using FD 0.
read LINE 0< ${FILE}
echo
echo "Contents of line: {LINE}"

# Redirect STDOUT to a file using FD 1, overwriting the file
head -n3 /etc/passwd 1> ${FILE}
echo
echo "Contents of file: ${FILE}"
cat ${FILE}

# Redirect STDERR to a file using FD 2.
ERR_FILE='file.err'
head -n3 /etc/passwd /giberish 2> ${ERR_FILE}

# Redirect STDOUT and STDERR to a file
head -n3 /etc/passwd /giberish 2>&1 ${FILE} # 2>&1 could also be used
head -n3 /etc/passwd /giberish &>> ${FILE}
echo
echo "Contents of ${FILE}: Using STDOUT and STDERR"
cat $FILE

# Redirect STDOUT and STDERR through a pipe
echo
echo "Redirect STDOUT and STDERR through pipe"
head -n3 /etc/passwd /gibersih |& cat -n

# Srnd output to STDERR
echo
echo "Error message!" >&2 | cat -n

# Discard STDOUT
echo
echo "Discarding STDOUT:"
head -n3 /etc/passwd /giberish > /dev/null

# Discard STDERR
echo
echo "Discarding STDERR:"
head -n3 /etc/passwd /giberish 2> /dev/null

# Discard both STDOUT and STDERR
echo
echo "Discrading both STDOUT and STDERR:"
head -n3 /etc/passwd /gibersish &> /dev/null

# Clean up
rm $FILE $ERR_FILE
