#!/usr/bin/env python3

"""Some functions exemplifying the use of control statements"""

__author__ = 'Ioan Evans (ie917@ic.ac.uk)'
__version__ = '0.0.1'

import sys
import doctest # import the doctest module

def even_or_odd(x=0): # if not specified, x should take value 0.
    """Find whether a number x is even or odd.
    
    >>> even_or_odd(10)
    '10 is Even!'
    
    >>> even_or_odd(5)
    '5 is Odd!'
    
    whenever a float is provided, then the closest integer is used:
    >>> even_or_odd(3.2)
    '3 is Odd!'
    
    in case of negative numbers, the positive is taken:
    >>> even_or_odd(-2)
    '-2 is Even!'
    
    """
    # define function to be tested
    if x % 2 == 0: # the conditional if
        return "%d is Even!" % x
    return "%d is Odd!" % x

#def main(argv):
#    print(even_or_odd(22))
#    print(even_or_odd(33))
#    return 0

#if __name__ == "__main__":
#    status = main(sys.argv)
#    sys.exit(status)

doctest.testmod() # to run with embedded tests
# python -m doctest -v test_control_flow.py
    # type into terminal to test "on the fly"
    # removes need for doctest.testmod()