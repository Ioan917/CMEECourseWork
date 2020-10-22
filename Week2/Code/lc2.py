#!/usr/bin/env python3

"""Writing conventional loops and list comprehensions to perform the same function."""

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

### List Comprehensions ###

# List of month, rainfall where the amount of rain was greater than 100 mm (high_rainfall_lc)

high_rainfall_lc = [i for i in rainfall if i[1]>100] # returns a list of tuples
print(high_rainfall_lc)
 
# List of just months where the mount of rain was less than 50 mm (low_rainfall_lc)

low_rainfall_lc = [i[0] for i in rainfall if i[1]<50]
print(low_rainfall_lc)

### Conventional Loops ###

# Greater than 100

greater_loop = []
for i in rainfall:
    if i[1]>100:
        greater_loop.append(i)
print(greater_loop)

# Less than 50

less_loop = []
for i in rainfall:
    if i[1]<50:
        less_loop.append(i[0])
print(less_loop)