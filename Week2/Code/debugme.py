#!/usr/bin/env python3

"""Some functions used to test %pdb for debugging."""

def buggyfunc(x):
    """Buggy function"""
    y = x
    for i in range(x):
        try:
            y = y-1
            z = x/y # ZeroDivisionError: division by zero
        except:
            print(f"This didn't work; x = {x}; y = {y}")
        else:
            print(f"OK; x = {x}; y = {y}, z = {z};")
    return z

buggyfunc(20)

## To debug function
# %pdb
# %run debugme.py

# Alternatively, run the code in ipython with run -d flag

## Paranoid programming
# import ipdb; ipdb.set_trace()
# insert the above code to pause the program to and inspect a given line or block of code