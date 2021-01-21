#!/usr/bin/env python3

"""Code exemplifying the use of argument variables."""

__appname__ = 'sysargv.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

import sys
print("This is the name of the script:", sys.argv[0])
print("Number of arguments:", len(sys.argv))
print("The arguments are:", str(sys.argv))