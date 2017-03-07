#!/bin/bash

#H
#H  script_name
#H
#H  DESCRIPTION
#H    This script is designed to do amazing things 
#H
#H  USAGE
#H    script_name [-h] [-d] -i value
#H
#H  ARGUMENTS
#H    -i value     Required important values 
#H    -d --doc     Optional. Documentation.
#H    -h --help    Optional. Help information.
#H
#H  NOTES: Uses the GLOBAL_VAR_NAME variable
#H

#D  COPYRIGHT: Riventek
#D  LICENSE:   GPLv2
#D  AUTHOR:    franky@riventek.com
#D
#D  REFERENCES
#D    [1] https://google.github.io/styleguide/shell.xml
#D    [2] http://wiki.bash-hackers.org/scripting/style
#D    [3] http://bash3boilerplate.sh/
#D    [4] http://www.tldp.org/LDP/abs/html/abs-guide.html
#D

#########################################################################
# GENERAL SETUP
#########################################################################   
# Exit on error. Append || true if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case any command in a pipe fails. e.g. mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
# set -o xtrace

#########################################################################
# VARIABLES SETUP 
#########################################################################
readonly RK_SCRIPT=$0              # Store the script name for help() and doc() functions
readonly RK_HAS_MANDATORY_ARGUMENTS="YES" # or "NO"
readonly TMPFILE=$(mktemp)      # Generate the temporary mask
# Add the commands and libraries required for the script to run
RK_DEPENDENCIES="sed grep date"    
RK_LIBRARIES="required_library.sh"

#########################################################################
# BASIC FUNCTIONS FOR ALL SCRIPTS
#########################################################################
# Function to extract the help usage from the script
help () {
	grep '^[ ]*[\#]*H' ${RK_SCRIPT} | sed 's/^[ ]*[\#]*H//g' | sed 's/^  //'
}
# Function to extract the documentation from the script
doc () {
  grep '^[ ]*[\#]*[HDF]' ${RK_SCRIPT} | sed 's/^[ ]*[\#]*F / \>/g;s/^[ ]*[\#]*[HDF]//g' | sed 's/^  //'
}
# Function to print the errors and warnings
echoerr() {
  echo -e ${RK_SCRIPT}" [$(date +'%Y-%m-%d %H:%M:%S')] $@" >&2
}
# Function to check availability and load the required librarys
check_libraries() {
  if [[ ${RK_LIBRARIES:-} != "" ]]; then
	  for library in ${RK_LIBRARIES:-}; do
	    local missing=0
	    if [[ -r ${library} ]]; then
		    source ${library}
	    else
		    echoerr "> Required library  not found: ${library}"
		    let missing+=1
	    fi
	    if [[ ${missing} -gt 0 ]]; then
		    echoerr "** ERROR **: Cannot found ${missing} required libraries, aborting\n"
		    exit 1
	    fi
	  done
  fi
}
# Function to check if the required dependencies are available
check_dependencies() {
  local missing=0
  if [[ ${RK_DEPENDENCIES:-} != "" ]]; then
	  for command in ${RK_DEPENDENCIES}; do
	    if ! hash "${command}" >/dev/null 2>&1; then
		    echoerr "> Required Command not found in PATH: ${command}"
		    let missing+=1
	    fi
	  done
	  if [[ ${missing} -gt 0 ]]; then
	    echoerr "** ERROR **: Cannot found ${missing} required commands are missing in PATH, aborting\n"
	    exit 1
	  fi
  fi
}

#D ## SCRIPT FUNCTIONS ##

#F
#F  FUNCTION:    function_name
#F  DESCRIPTION: This function is designed to do some of the amazing things
#F  GLOBALS
#F    GLOBAL_VAR1  Variable and use of it
#F  ARGUMENTS
#F    $1     Required important values 
#F    $2     Optional.
#F
function_name()
{
  local first_parameter
  local second_parameter
  local tmpfile
  tmpfile=${TMPFILE}-${FUNCNAME[0]}

  # Checking the parameters and copy to meaningful local variables.
  if [[ "${1:-}" != "" ]]; then
    first_parameter="${1:-}"    
  else
	  echoerr "** ERROR in ${FUNCNAME[0]}() ** : Cannot the find first parameter !"
    exit 1
  fi
  if [[ "${2:-}" != "" ]]; then
    second_parameter="${2:-}"
  else
    second_parameter=""
  fi

  # Main function code
  
  # Cleaning up 
  rm -Rf ${tmpfile}*  
}

#########################################################################
# MAIN SCRIPT
#########################################################################
# Check & Load required libraries
check_libraries
# Check if we have all the required commands
check_dependencies

# Command Line Parsing
echo -e "\n"
if [[ "${1:-}" == "" ]] && [[ ${RK_HAS_MANDATORY_ARGUMENTS} = "YES" ]]; then
  help
  exit 1
else
  while [[ "$1" != "" ]]
  do
	  case $1 in
      -i)
		    shift
		    value=$1
		    # We expect and extra value after the -i option
		    echo "- Setting value=$value"
		    shift
		    ;;
      -d|--doc)  
		    shift
		    doc
		    exit 0
		    ;;
      -h|--help)
		    shift
		    help
		    exit 0
		    ;;
      *)
		    help
		    exit 1
		    ;;
	  esac
  done
fi

#####
###
#  Magic code ....
###
#####

# Final clean up
if [[ ${TMPFILE:-} != "" ]]; then
  rm -f ${TMPFILE:-}*
fi
