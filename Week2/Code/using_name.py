#!/usr/bin/env python3

"""Example of the use of __name__ in python programs 
to run an if / else statement depending on how the program is being run"""

__appname__ = 'using_name.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

# Filename: using_name.py

if __name__ == '__main__':
    print('This program is being run by itself')
else:
    print('I am being imported from another module')

print("This module's name is:" + __name__)