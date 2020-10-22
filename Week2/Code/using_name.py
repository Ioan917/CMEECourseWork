#!/usr/bin/env python3

"""Example of the use of __name__ in python programs 
to run an if / else statement depending on how the program is being run"""

# Filename: using_name.py

if __name__ == '__main__':
    print('This program is being run by itself')
else:
    print('I am being imported from another module')

print("This module's name is:" + __name__)