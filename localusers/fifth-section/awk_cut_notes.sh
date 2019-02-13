#!/bin/bash

# Getting familiar with Cut and Awk Command
echo -e 'one\ttwo\tthree\tfour' | cut -f 1,2,4

# Getting familar with awk
# AWK is used to parse and print strings
awk -F ':' '{print "Col: " $1 " " $3 }' /etc/passwd

# the -F option is for the filed to split on
# inside the praces, you can set the value you want to print
# awk is mostly used for data that isnt clean seperated with 
# varying length white spaces or for delimeters that are larger
# than one character
# $NF in awk is for last character instance in field, instead of using $1 etc.
