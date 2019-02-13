#!/bin/bash

# This script will be using regular expresions, grep, awk and cut
# to process the active ports on the computer using the netstat 
# command.

netstat -nutl | grep -E "^Active|^Prot"
echo
netstat -nutl | grep -vE "^Active|^Prot"

# -E for extended regular expressions with grep
# -v to negate the pattern that is searched for; i.e. NOT this pattern
# | the or operator for a regular expression statement
# ^ The anchor for the front of a line to check if pattern exists
echo
echo "Filtered for ports:"
netstat -4nutl | grep -vE "^A|^P" | awk '{print $4}' | cut -d ':' -f 2
# Processing:
# - Nestat for data
# - grep to take out headers
# - awk to select fourth coloumn
# - cut to seperate at the colon
echo

