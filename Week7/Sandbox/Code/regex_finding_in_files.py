#!/usr/bin/env python3

import re

f = open("../Data/TestOaksData.csv", "r")
found_oaks = re.findall(r"Q[\w\s].*\s", f.read())

print(found_oaks)