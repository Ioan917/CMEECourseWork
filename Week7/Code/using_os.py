#!/usr/bin/env python3

"""Use subprocess.os.walk to find and list directories, subdirectories and files."""

__appname__ = 'using_os.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

## Packages
import subprocess

# Use the subprocess.os module to get a list of files and directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

home = subprocess.os.path.expanduser("../../")
p = subprocess.os.walk(home, topdown=True, onerror=None, followlinks=False)
list(p)

#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
CMEECourseWork = subprocess.os.path.expanduser("../../")

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(CMEECourseWork):
    for y in subdir:
        if y.startswith('C'):
            FilesDirsStartingWithC.append(y)
    for z in files:
        if z.startswith('C'):
            FilesDirsStartingWithC.append(z)
print(FilesDirsStartingWithC)

#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:

# Create a list to store the results.
FilesDirsStartingWithC_or_c = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(CMEECourseWork):
    for y in subdir:
        if y.startswith(("C","c")):
            FilesDirsStartingWithC_or_c.append(y)
    for z in files:
        if z.startswith(("C","c")):
            FilesDirsStartingWithC_or_c.append(z)
print(FilesDirsStartingWithC_or_c)

#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:

# Create a list to store the results.
DirsStartingWithC_or_c = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(CMEECourseWork):
    for y in subdir:
        if y.startswith(("C","c")):
            DirsStartingWithC_or_c.append(y)
print(DirsStartingWithC_or_c)