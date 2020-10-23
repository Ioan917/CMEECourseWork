#!/usr/bin/env python3

"""Example of storing objects in python"""

## Storing objects

# To save an object (even complex) for later use
my_dictionary = {"a key": 10, "another key": 11}

import pickle

f = open('../Data/testp.p', 'wb')
pickle.dump(my_dictionary, f)
f.close()

## Load the data again
f = open('../Data/testp.p', 'rb')
another_dictionary = pickle.load(f)
f.close()

print(another_dictionary)