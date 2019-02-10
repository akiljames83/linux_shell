#!/bin/bash

# Using functions in bash

# First method
function log1 {
  echo "First way to make a function"
}

# Second method
log2() {
  echo "Second way to make a function"
}

# A function must be defined above before it can be called
# Call the functions
log1
log2


# New shell builtin local, allows one to take the parameters for a bash function
# local variables cannot be accessed outside of the function
function log {
  local MESSAGE="$*"
  echo $MESSAGE
}

log this is a string of arguments
log 'hello there'
