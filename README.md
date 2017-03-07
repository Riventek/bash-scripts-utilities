BASH SCRIPTS UTILITES
===============
After many years working with BASH scripts and having eacht time we
start to look and search for old scripts to re-use and evolution in
style, we took the decison at Riventek to make it easier and more
consistent our way of creating BASH scripts. These are the outcome of
the consolidating and centralizing a lot of knowledge around internet
and inside Riventek members trying to be simple but complete at the
same time. Hope it helps :) to someone else.

TEMPLATES
========
These templates are meant for bash libraries & scripts to be used to
accelerate the creation of new scripts. They are meant for complex,
long scripts not for simple wrappers of quick hacks. These are used
usually to make some test automation, system integration or setup.

The 2 templates are the following:
* **script_template.sh** : This is a template for generic scripts.
* **lib_template.sh** : This is a template for libraries (sometimes
  called packages). This are special scripts that define functions
  that will be shared 

HOW-TO USE THESE TEMPLATES
---------------------------
These templates are also trying to incorporate and facilitate some
coding guidelines and some structure. Even they should be quite
self-explanatory , here you have a brief explanation of what you will
find there.

### BASIC STRUCTURE
The basic structure of a script simply reads:
```
    #!/bin/bash
	< HEADER COMMENTS >
	< GENERAL SETUP >
	< CONFIGURATION VARIABLES >
	< FUNCTIONS DEFINITIONS >
	< MAIN CODE >
```

### COMMENTS
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
     have the most basic description and parameters in one single
     place and provide the most basic information for a script.

     * `#D` -> These comments will include the extra and extended
         information (including functions).These can be anything. Some
         recomended ones would be: 
		 - Copyright
		 - License
		 - Author
		 - References.
        The `doc()` function will display them, including
        functions. These is meant to include in the script some extra
        information that is not critical to have a basic understanding.

     * `#F` -> These comments are meant for the headers for the functions. It's meant to facilitate extended
             processing for documentation ( e.g. HTML ).The Function recommended comments:
             - Description of the function
             - Global variables used and modified
             - Arguments taken
             - Returned values other than the default exit status of the last command run
             The `doc()` function will display them. This is not used
             explicitely now by the functions but will facilitate some simple and extended
             document processing in the future.

### DEPENDENCIES AND LIBRARIES
Includes the `RK_DEPENDENCIES`and `RK_LIBRARIES` extended comments and
cc`check_libraries()`. These are meant to automate and facilitate the
dependency check (on required commanccds) and load (libraries) for the
scripts:

	* `RK_DEPENDENCIES -> To list all the required commands for the
                          script. These will be checked for accesibility 
                          by the function `check_dependencies()`.
    * `RK_LIBRARIES` -> To list all the required commands for the
                          script. These will be checked for
                          accesibility 
                          and loaded (sourced) by the function `check_libraries()`.

### BASIC FUNCTIONS
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
