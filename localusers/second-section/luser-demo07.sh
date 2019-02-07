#!/bin/bash

# Demonstrate the use of the shift command and the while loop

# Use other syntax for accessing positional parameters
echo "Paramter 1: ${1}"
echo "Paramter 2: ${2}"
echo "Paramter 3: ${3}"
echo

# The true command always evaluates to true
true
echo "True is successful ? : $?"

# Use the while loop to iterate through values
while [[ "${#}" -ne 0 ]]
do
  echo "Number of parameters remaining: ${#}"
  echo "Paramter 1: ${1}"
  echo "Paramter 2: ${2}"
  echo "Paramter 3: ${3}"
  echo
  shift
done
