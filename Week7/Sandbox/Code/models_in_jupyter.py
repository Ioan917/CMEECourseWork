%matplotlib inline
import matplotlib.pyplot as p

from sympy import *
import scipy as sc
init_printing() # for pretty printing equations

### Sympy preliminaries

## Symbolic variables

# Create a symbolic variable
x = var("x")
type(x) # check it's class

# Define multiple symbolic variables at once
a, b, c = var("a, b, c")

# Add assumptions (constraints) to symbolic vars
x = var("x", real = True)
x.is_imaginary # False

x = Symbol("x", positive = True)
x > 0 # True
x < 0 # False

## Symbolic equations

# Define mathematical equation
MyFun = (pi + x)**2; MyFun

MyFun = N_0 + (N_max - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((N_max - N_0) * log(10)) + 1)); MyFun