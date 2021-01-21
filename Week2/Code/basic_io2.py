#!/usr/bin/env python3

"""Example of exporting data from python"""

__appname__ = 'basic_io2.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

## File output

# Save the elements of a list to a file
list_to_save = range(100)

f = open('../Results/testout.txt', 'w')
for i in list_to_save:
    f.write(str(i) + '\n') # add a new line at the end

f.close()