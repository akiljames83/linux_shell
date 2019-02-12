#!/bin/bash

# Just a small script showing some math basics
# Basic function to print all values
disp() {
  echo "NUM: $NUM"
  echo "NUMA: $NUMA"
  echo "NUMB: $NUMB"
  echo "TOTAL: $TOTAL"
  echo ""
}
# Typical math expression
NUM=$(( 1 + 2))

# Storing and manipulating numbers
NUMA='3'
NUMB='6'
TOTAL=$(( NUMA + NUMB ))

## FIRST DISPLAY ##
disp

# Let operation
let NUM++
let NUMB='1 + 4'

## SECOND DISPLAY ##
disp

# Using expr
expr 1 + 1
NUM=`expr 5 + 7`
# Increment and decrement numbers
(( NUM++ ))
(( NUM *= 3 ))

# Default in bash in integer division
(( NUM /= 2 ))

# Integer division with expr
NUMA=`expr 3 / 4`
# Same thing with awk: Funky syntax
NUMB=`awk 'BEGIN {print 6/4}'`

## THIRD DISP ##
disp
