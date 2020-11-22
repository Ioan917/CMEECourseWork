#!/usr/bin/env python3

import re

MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory"
match = re.search(r"[\w\s]+,\s[\w.-]+@[\w\.-]+,\s[\w\s]+", MyStr)
match.group()

# \s[\w.-]+@[\w\.-]+ section finds only the email

# Without grouping the regex
match.group(0)

# Create groups uring ( ):
match = re.search(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+),\s([\w\s&]+)", MyStr)
if match:
    print(match.group(0)) # Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory
    print(match.group(1)) # Samraat Pawar
    print(match.group(2)) # s.pawar@imperial.ac.uk
    print(match.group(3)) # Systems biology and ecological theory