#!/usr/bin/env python3

import re

## Looking for email addresses in a string
MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory"

match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+", MyStr)
match.group() # "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory"

match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s]+", MyStr)
match.group()

# Make the email address part of the regex more robust
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s]+", MyStr)
match.group()