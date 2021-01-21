#!/usr/bin/env python3

"""Creating a conventional loop to present data from a tuple in a new format."""

__appname__ = 'tuple.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# Short script to print these on a separate line or output block by species 

### Conventional loop ###

for i in birds:
    print("Latin name:",i[0],'\n' + "Common name:",i[1],'\n' + "Mass:",i[2],'\n')

### List comprehension ###

#data = "".join([str("Latin name:%s\nCommon name:%s\nMass:%s\n" + '\n') % (row[0], row[1], row[2]) for row in birds])
#print(data)