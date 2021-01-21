#!/usr/bin/env python3

"""Exploring use of control statements and module like structure."""

__appname__ = 'cfexercises1.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

import sys

## foo_1()

def foo_1(x = 1):
    """Find the square root of x."""
    y = x ** 0.5
    return "The square root of %d is %d." % (x, y)

## foo_2()

def foo_2(x=2, y=3):
    """Return the larger of the two input values."""
    if x>y:
        return "The larger numer is %d." % x
    return "The larger number is %d." % y

## foo_3()

def foo_3(x=4, y=5, z=6):
    """Order the three input values from lowest to highest 2/3 of the time."""
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    if x > y:
        tmp = y 
        y = x
        x = tmp
    return "From smallest to largest, the three numbers are %d, %d, %d." % (x, y, z)

## foo_4()

def foo_4(x=7):
    """Calculate the factorial of x."""
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return "The factorial of %d is %d." % (x, result)

## foo_5()

def foo_5(x=5):
    """Calculate the factorial of x recursively."""
    foo_5_input = x
    if x == 1:
        return 1
    return x * foo_5(x - 1)

## foo_6()

def foo_6(x=9):
    """Calculate the factorial of x using a while loop."""
    y = x
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return "The factorial of %d is %d." % (y, facto)


def main(argv):
    """Main entry of the program"""
    print(foo_1(22))
    print(foo_2(33, 21))
    print(foo_3(120, 146, 132))
    print(foo_4(12))
    
    foo_5_input = 6
    foo_5_output = foo_5(foo_5_input)
    print("The factorial of %d is %d" % (foo_5_input, foo_5_output))
    
    print(foo_6(9))
    
    return 0

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)