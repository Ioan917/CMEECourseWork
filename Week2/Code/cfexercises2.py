#!/usr/bin/env python3

"""Functions exemplifying the combined use of conditionals and loops."""

__appname__ = 'cfexercises2.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

for j in range(12):
    if j % 3 == 0:
        print('hello') # hello prints 4 times

for j in range(15):
    if j % 5 == 3:
        print('hello')
    elif j % 4 == 3:
        print('hello') # hello prints 5 times

z = 0
while z != 15:
    print('hello')
    z = z + 3 # hello prints 5 times

z = 12
while z < 100:
    if z == 31:
        for k in range(7):
            print('hello')
    elif z == 18:
        print('hello')
    z = z + 1 # hello prints 8 times