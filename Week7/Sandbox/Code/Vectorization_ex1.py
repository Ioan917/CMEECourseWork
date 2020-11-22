#!/usr/bin/env python3

## We have two simple 1D arrays
# a and b
# each of length N

## We want to calculate a new array c in which each 
# entry is the product of the two corresponding entries 
# a and b

## Operation is called the entrywise prodyct of a and b

## Imports
import scipy as sc


## Loop approach
def loop_product(a, b):
    N = len(a)
    c = sc.zeros(N)
    for i in range(N):
        c[i] = a[i] * b[i]
    return c

## Vectorization approach
def vect_product(a, b):
    return sc.multiply(a, b)

### Compare the runtimes of loop_product and vect_product
# on increasingly large randomly-generated 1D arrays

import timeit

array_lengths = [1, 100, 10000, 1000000, 100000000]
t_loop = []
t_vect = []

for N in array_lengths:
    print("\nSet N = %d" %N)

    # randomly generate our 1D arrays of length N
    a = sc.random.rand(N)
    b = sc.random.rand(N)

    # time loop_product 3 times and save the mean execution time
    timer = timeit.repeat("loop_product(a, b)", globals = globals().copy(), number = 3)
    t_loop.append(1000 * sc.mean(timer))
    print("Loop method took %d ms on average." %t_loop[-1])

    # time vect_product 3 times and save the mean execution time
    timer = timeit.repeat("vect_product(a, b)", globals = globals().copy(), number = 3)
    t_vect.append(1000 * sc.mean(timer))
    print("Vectorized method took %d ms on average." %t_vect[-1])

## Compare timings in a plot
p.figure()
p.plot(array_lengths, t_loop, label = "loop method")
p.plot(array_lengths, t_vect, label = "vect method")
p.xlabel("Array length")
p.ylabel("Execution time (ms)")
p.legend()
p.show()