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
#D    [5] http://misc.flogisoft.com/bash/tip_colors_and_formatting
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
# Trap signals to have a clean exit
trap clean_exit SIGHUP SIGINT SIGTERM
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

# CODES FOR TERMINAL - Optimized for compatibility - use printf also for better compatibility
# Styles
readonly BOLD="\e[1m"
readonly BOLD_OFF="\e[21m"
readonly UNDERLINE="\e[4m"
readonly UNDERLINE_OFF="\e[24m"
readonly REVERSE="\e[7m"
readonly REVERSE_OFF="\e[27m"
readonly STYLE_OFF="\e[0m"

# Colors Foreground
readonly FG_BLACK="\e[30m"
readonly FG_RED="\e[31m"
readonly FG_GREEN="\e[32m"
readonly FG_YELLOW="\e[33m"
readonly FG_BLUE="\e[34m"
readonly FG_MAGENTA="\e[35m"
readonly FG_CYAN="\e[36m"
readonly FG_LIGHTGREY="\e[37m"
readonly FG_DARKGREY="\e[90m"
readonly FG_LIGHTRED="\e[91m"
readonly FG_LIGHTGREEN="\e[92m"
readonly FG_LIGHTYELLOW="\e[93m"
readonly FG_LIGHTBLUE="\e[94m"
readonly FG_LIGHTMAGENTA="\e[95m"
readonly FG_LIGHTCYAN="\e[96m"
readonly FG_WHITE="\e[97m"
readonly FG_DEFAULT="\e[39m"

# Colors Background
readonly BG_BLACK="\e[40m"
readonly BG_RED="\e[41m"
readonly BG_GREEN="\e[42m"
readonly BG_YELLOW="\e[43m"
readonly BG_BLUE="\e[44m"
readonly BG_MAGENTA="\e[45m"
readonly BG_CYAN="\e[46m"
readonly BG_LIGHTGREY="\e[47m"
readonly BG_DARKGREY="\e[100m"
readonly BG_LIGHTRED="\e[101m"
readonly BG_LIGHTGREEN="\e[102m"
readonly BG_LIGHTYELLOW="\e[103m"
readonly BG_LIGHTBLUE="\e[104m"
readonly BG_LIGHTMAGENTA="\e[105m"
readonly BG_LIGHTCYAN="\e[106m"
readonly BG_WHITE="\e[107m"
readonly BG_DEFAULT="\e[49m"

# ## SCRIPT VARIABLES ##

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
# Function to clean-up when exiting
clean_exit() {
    local exit_code

    printf "\n${FG_GREEN}>> Cleaning up ...${STYLE_OFF}"
    if [ "${1:-}" == "" ]; then
        let exit_code=0
    else
        let exit_code=$(( $1 ))
    fi
    if [[ ${TMPFILE:-} != "" ]]; then
        rm -f ${TMPFILE:-}*
    fi
    printf "DONE !\n"

    exit $exit_code
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
		    clean_exit 1
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
	    clean_exit 1
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
    clean_exit 1
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
  clean_exit 1
else
  while [[ "${1:-}" != "" ]]
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
		    clean_exit 0
		    ;;
      -h|--help)
		    shift
		    help
		    clean_exit 0
		    ;;
      *)
		    help
		    clean_exit 1
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
clean_exit
