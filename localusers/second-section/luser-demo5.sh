#!/bin/bash

# Script to generate a list of random passowrds

# A random number as a passowrd
PASSWORD="${RANDOM}"
echo "$PASSWORD"

# Three random numbers together
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "$PASSWORD"

# Using the Posix time to represent the password
PASSWORD=`date +%s`
echo "$PASSWORD"

# Use the nano second option to introduce more precise number - thus harder to guess
PASSWORD=`date +%s%N`
echo "$PASSWORD"

# Better password using a cryptographic hash function (sha256sum)
PASSWORD=`date +%s%N | sha256sum | head -c32`
echo "$PASSWORD"

# Even better password!
PASSWORD=`date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48`
echo $PASSWORD

echo 'Last one!'
# Append a special character to the password
SPECIAL='!@#$%^&*()_+-='
CHAR=`echo "${SPECIAL}" | fold -w1 | shuf | head -c1`
PASSWORD=`date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48`
echo $PASSWORD
