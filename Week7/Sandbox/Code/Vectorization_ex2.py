#!/usr/bin/env python3

### Trade-offs to vectorizing - memory usage
# computer needs to hold much more memory in order to
# calculate many steps simultaneously

import scipy as sc

N = 1000000000

a = sc.random.rand(N)
b = random.rand(N)
c = vect_product(a, b)

# if no error, remove a, b, c from memory