#!/usr/bin/env python3

"""Five examples of creating variables inside and outside functions 
i.e. global and local variables"""

__appname__ = 'scope.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

## 1

_a_global = 10 # a global variable

if _a_global >= 5:
    _b_global = _a_global + 5 # also a global variable

def a_function():
    """Assigning and manipulating global and lcoal variables"""
    _a_global = 5 # a local variable
    
    if _a_global >= 5:
        _b_global = _a_global + 5 # also a local variable
    
    _a_local = 4
    
    print("Inside the function, the value of _a_global is ", _a_global)
    print("Inside the function, the value of _b_global is ", _b_global)
    print("Inside the function, the value of _a_local is ", _a_local)
    
    return None

a_function()

print("Outside the function, the value of _a_global is ", _a_global)
print("Outside the function, the value of _b_global is ", _b_global)

## 2

_a_global = 10

def a_function():
    """Assigning and manipulating global and lcoal variables"""
    _a_local = 4
    
    print("Inside the function, the value _a_local is ", _a_local)
    print("Inside the function, the value of _a_global is ", _a_global)
    
    return None

a_function()

print("Outside the function, the value of _a_global is", _a_global)

## 3

_a_global = 10

print("Outside the function, the value of _a_global is", _a_global)

def a_function():
    """Assigning and manipulating global and lcoal variables"""
    global _a_global
    _a_global = 5
    _a_local = 4
    
    print("Inside the function, the value of _a_global is ", _a_global)
    print("Inside the function, the value _a_local is ", _a_local)
    
    return None

a_function()

print("Outside the function, the value of _a_global now is", _a_global)

## 4

def a_function():
    """Assigning and manipulating global and lcoal variables"""
    _a_global = 10

    def _a_function2():
        """Function inside a function."""
        global _a_global
        _a_global = 20
    
    print("Before calling a_function, value of _a_global is ", _a_global)

    _a_function2()
    
    print("After calling _a_function2, value of _a_global is ", _a_global)
    
    return None

a_function()

print("The value of a_global in main workspace / namespace is ", _a_global)

## 5

_a_global = 10

def a_function():
    """Assigning and manipulating global and lcoal variables"""
    def _a_function2():
        """Assigning and manipulating global and lcoal variables"""
        global _a_global
        _a_global = 20
    
    print("Before calling a_function, value of _a_global is ", _a_global)

    _a_function2()
    
    print("After calling _a_function2, value of _a_global is ", _a_global)

a_function()

print("The value of a_global in main workspace / namespace is ", _a_global)