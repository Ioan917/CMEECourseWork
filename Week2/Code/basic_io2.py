#!/usr/bin/env python3

"""Example of exporting data from python"""

## File output

# Save the elements of a list to a file
list_to_save = range(100)

f = open('../Sandbox/testout.txt', 'w')
for i in list_to_save:
    f.write(str(i) + '\n') # add a new line at the end

f.close()