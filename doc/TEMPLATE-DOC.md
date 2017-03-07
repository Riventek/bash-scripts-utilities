HOW-TO USE BASH TEMPLATES
=====================
These templates are also trying to incorporate and facilitate some
coding guidelines and some structure. Even they should be quite
self-explanatory , here you have a brief explanation of what you will
find there.

BASIC STRUCTURE
---------------
The basic structure of a script simply reads:

    #!/bin/bash
	< HEADER COMMENTS >
	< GENERAL SETUP >
	< CONFIGURATION VARIABLES >
	< FUNCTIONS DEFINITIONS >
	< MAIN CODE >

COMMENTS
----------
Includes the `#H`,`#D` and `#F` extended comments and also the basic
functions `help()` and `doc()`. These are meant to automate and
facilitate documentation for scripts:

* `#H` -> These comments will be shown as help for the script. They
	 are in the File Header of the script. The minimum recommended
	 information is:
		 - Script name.
		 - Brief Description of the Script.
		 - Usage, with parameters ( optional in brackets[] ).
		 - Arguments descriptions.
The `help()` function will display them. These will facilitate to
have the most basic description and parameters in one single place and 
provide the most basic information for a script.

* `#D` -> These comments will include the extra and extended
         information (including functions).These can be anything. Some
         recomended ones would be:
		 - Copyright
		 - License
		 - Author
		 - References.
The `doc()` function will display them, including functions. These is
meant to include in the script some extra information that is not
critical to have a baisc understanding.

* `#F` -> These comments are meant for the headers for the
             functions. It's meant to facilitate extended processing
             for documentation ( e.g. HTML ).The Function recommended
             comments:
             - Description of the function
             - Global variables used and modified
             - Arguments taken
             - Returned values other than the default exit status of
			 the last command run.
The `doc()` function will display them. This is not used explicitely
now by the functions but will facilitate some simple and
extended document processing in the future.

Take into account that the first 2 spacea after `#D` ,`#F` & `#H` will be removed.

DEPENDENCIES AND LIBRARIES
--------------------------
Includes the `RK_DEPENDENCIES`and `RK_LIBRARIES` extended comments and
cc`check_libraries()`. These are meant to automate and facilitate the
dependency check (on required commanccds) and load (libraries) for the
scripts:

* `RK_DEPENDENCIES` -> To list all the required commands for the
                          script. These will be checked for accesibility 
                          by the function `check_dependencies()`.
* `RK_LIBRARIES` -> To list all the required commands for the
                          script. These will be checked for accesibility 
                          and loaded (sourced) by the function `check_libraries()`.

BASIC FUNCTIONS
---------------
These are simple helper functions to facilitate the scripts writing
and management.

* `help ()` -> Function to extract the help usage from the
      script. It will use the `#H` comments as explained in the
      **COMMENTS** section
* `doc ()` -> Function to extract the documentation from the
	script. It will use the `#D` and the `#F` comments as explained in
	the  **COMMENTS** section
	  

REFERENCES
========
- [Google Bash Style Guide] (https://google.github.io/styleguide/shell.xml)
- [Scripting with Style]  (http://wiki.bash-hackers.org/scripting/style)
- [Bash3 Boilerplate] (http://bash3boilerplate.sh/)
- [Advanced Bash guide] (http://www.tldp.org/LDP/abs/html/abs-guide.html)
- [How to detect if a script is being sourced] (http://stackoverflow.com/questions/2683279/how-to-detect-if-a-script-is-being-sourced)
