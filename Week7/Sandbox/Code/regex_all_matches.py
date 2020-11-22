#!/usr/bin/env python3

import re

MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a-academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a_academic@imperial.ac.uk, Some other stuff thats even more boring"

# re.findall() returns a list of all the emails found
emails = re.findall(r"[\w\.-]+@[\w\.-]+", MyStr)
for email in emails:
    print(email)