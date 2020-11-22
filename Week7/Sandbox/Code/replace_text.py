#!/usr/bin/env python3

import re
import urllib3

conn = urllib3.PoolManager() # open a connection
r = conn.request("GET", "https://www.imperial.ac.uk/silwood-park/academic-staff/")
webpage_html = r.data # read in the webpage's contents

type(webpage_html) # returned as bytes, not strings

My_Data = webpage_html.decode() # decode it

New_Data = re.sub(r"\t", " ", My_Data) # replace all tabs with space
print(New_Data)