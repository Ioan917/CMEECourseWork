#!/usr/bin/env python3

import re
import urllib3

conn = urllib3.PoolManager() # open a connection
r = conn.request("GET", "https://www.imperial.ac.uk/silwood-park/academic-staff/")
webpage_html = r.data # read in the webpage's contents

type(webpage_html) # returned as bytes, not strings

My_Data = webpage_html.decode() # decode it

pattern = r"Dr\s+\w+\s+\w+|Professor\s+\w+\s+\w+"
regex = re.compile(pattern) # example use of re.compile()
# can also ignore case with re.IGNORECASE
for match in regex.finditer(My_Data): # example use of re.finditer
    print(match.group())

# Challenge:
# eliminate repeat matches
# group to separate title from first and second names
# extract names that have unexpected characters which are currently
# not being matvhed properly