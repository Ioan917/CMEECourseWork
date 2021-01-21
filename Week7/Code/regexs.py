#!/usr/bin/env python3

"""Examples of the use of regular expressions."""

__appname__ = 'regexes.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

## Packages
import re

my_string = "a given string"

## Find a space in the string
match = re.search(r'\s', my_string)
print(match) # <re.Match object; span=(1, 2), match=' '>
# see the match
match.group() # ' '

## Try another pattern
match = re.search(r'\d', my_string)
print(match) # None

## Use if to know whether a pattern was matched
MyStr = 'an example'

match = re.search(r'\w*\s', MyStr) # what pattern is this?

if match:                      
    print('found a match:', match.group()) 
else:
    print('did not find a match')

## Some more regexes
match = re.search(r'2' , "it takes 2 to tango")
match.group() # '2'

match = re.search(r'\d' , "it takes 2 to tango")
match.group() # '2'

match = re.search(r'\d.*' , "it takes 2 to tango")
match.group() # '2 to tango'

match = re.search(r'\s\w{1,3}\s', 'once upon a time')
match.group() # ' a '

match = re.search(r'\s\w*$', 'once upon a time')
match.group() # ' time'

## Switch to a more compact syntax
re.search(r'\w*\s\d.*\d', 'take 2 grams of H2O').group() # 'take 2 grams of H2'

re.search(r'^\w*.*\s', 'once upon a time').group() # 'once upon a '

## Make it non-greedy and terminate at the first found instance of a pattern
re.search(r'^\w*.*?\s', 'once upon a time').group() # 'once '

## Try matching an HTML tag
re.search(r'<.+>', 'This is a <EM>first</EM> test').group() # '<EM>first</EM>'
# Make + lazy
re.search(r'<.+?>', 'This is a <EM>first</EM> test').group() # '<EM>'

## Moving on from greed and laziness
re.search(r'\d*\.?\d*','1432.75+60.22i').group() # '1432.75'

## A couple more examples
re.search(r'[AGTC]+', 'the sequence ATTCGT').group() # 'ATTCGT'

re.search(r'\s+[A-Z]\w+\s*\w+', "The bird-shit frog's name is Theloderma asper.").group()
' Theloderma asper'

## Looking for email addresses in a string
MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+",MyStr)
match.group()
# 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'

MyStr = 'Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecological theory'

#match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+",MyStr)
#match.group() # returns attribute error

# Mkae email address part of the regex more robust
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s]+",MyStr)
match.group()