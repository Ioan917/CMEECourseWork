#!/usr/bin/env python3

"""Functions using non-vectorized methods, used to compare timing between non-vectorized and vectorized scripts."""

__appname__ = 'profileme.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

def my_squares(iters):
    "Square the iters."
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    "Append to 'string' each character / number in 'iters' and add a comma between each."
    out = ''
    for i in range(iters):
        out += string.join(", ")
    return out

def run_my_funcs(x,y):
    "Call my_squares and my_join functions and print the input values to the console."
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")

# to profile, type run -p profileme.py in the ipython console