#!/usr/bin/env python3

"""Finding strings and reformatting data using regular expressions."""

import re

# Read the file (using a different, more python 3 way, just for fun!)
with open('../Data/blackbirds.txt', 'r') as f:
    text = f.read()

# replace \t's and \n's with a spaces:
text = text.replace('\t',' ')
text = text.replace('\n',' ')
# You may want to make other changes to the text. 

# In particular, note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform to ASCII:

text = text.encode('ascii', 'ignore') # first encode into ascii bytes
text = text.decode('ascii', 'ignore') # Now decode back to string

# Now extend this script so that it captures the Kingdom, Phylum and Species
# name for each species and prints it out to screen neatly.

# Kingdon, Phylum, Species

kingdom = re.findall(r"(?<=\bKingdom\s)(\w+)", text)
phylum = re.findall(r"(?<=\bPhylum\s)(\w+)", text)
species = re.findall(r"(?<=\bSpecies\s)(\w*\s\w*)", text)

print([kingdom[0],phylum[0],species[0]])
print([kingdom[1],phylum[1],species[1]])
print([kingdom[2],phylum[2],species[2]])
print([kingdom[3],phylum[3],species[3]])

# Hint: you may want to use re.findall(my_reg, text)... Keep in mind that there
# are multiple ways to skin this cat! Your solution could involve multiple
# regular expression calls (slightly easier!), or a single one (slightly harder!)
#
# Here are some example outputs of possible solutions (These are not the only two ways to do this!): 
# Solution 1:
#
# ['Animalia', 'Chordata ', 'Euphagus carolinus']
# ['Animalia', 'Chordata ', 'Euphagus cyanocephalus']
# ['Animalia', 'Chordata ', 'Turdus boulboul']
# ['Animalia', 'Chordata ', 'Agelaius assimilis']
# ===============
# 
# Solution 2:
#
#  [('Animalia', 'Chordata', 'Euphagus carolinus'), ('Animalia', 'Chordata', 'Euphagus cyanocephalus'), ('Animalia', 'Chordata', 'Turdus boulboul'), ('Animalia', 'Chordata', 'Agelaius assimilis')]
# 