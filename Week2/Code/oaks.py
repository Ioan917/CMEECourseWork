#!/usr/bin/env python3

"""Exercise to compare the use of conventional loops and list comprehensions."""

__appname__ = 'oaks.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

## Finds just those taxa that are oak trees from a list of species

taxa = [    'Quercus robur',
            'Franxinus excelsior',
            'Pinus sylvestris',
            'Quercus cerris',
            'Quercus petraea',
        ]

def is_an_oak(name):
    """Return lower case of species genera"""
    return name.lower().startswith('quercus ')

##Using for loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species)
print(oaks_loops)

##Using list comprehensions
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print(oaks_lc)

##Get names in UPPER CASE using loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper())
print(oaks_loops)

##Get names in UPPER CASE using list comprehensions
oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)