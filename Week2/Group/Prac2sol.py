### Ioan ###

# Comprehensions      

# >100

rainfall_lc_great100 = tuple([i for i in rainfall if i[1]>100])
print(rainfall_lc_great100)
 
# <50

rainfall_lc_less50 = [i[0] for i in rainfall if i[1]<50]
print(rainfall_lc_less50)

# Loops

## Greater than 100

greater_loop = []
for i in rainfall:
    if i[1]>100:
        greater_loop.append(i)
print(greater_loop)

## Less than 50

less_loop = []
for i in rainfall:
    if i[1]<50:
        less_loop.append(i)
print(less_loop)

### Ioan ###


#Danica
#(1)
my_list = [(x, y) for x, y in rainfall if y > 100]
print(my_list)

#(2)
months = [x for x, y in rainfall if y < 50]
print(months)

#(3)
my_list = []
months = []
for x, y in rainfall:
    if y > 100:
        my_list.append((x, y))
print(my_list)

for x, y in rainfall:
    if y < 50:
        months.append(x)
print(months)
#Danica


#~~~~~ELIN~~~~~~~
print("LIST COMPREHENSIONS")

high_rainfall = [month for month in rainfall if month[1] > 100] #month[1] refers to the number in each tuple
print("Months and rainfall values when the amount of rain was greater than \
100mm:\n", high_rainfall)

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm.

low_rainfall = [month[0] for month in rainfall if month[1] < 50]
print("Months when the amount of rain was less than 50mm:\n", low_rainfall)

#Print new line between list comprehensions and for loops
print("\n")

# (3) Now do (1) and (2) using conventional loops (you can choose to do
# this before 1 and 2 !).

print("FOR LOOPS")

high_rainfall = []
for month in rainfall:
    if month[1] > 100:
        high_rainfall.append(month)
print("Months and rainfall values when the amount of rain was greater than \
100mm:\n", high_rainfall)

low_rainfall = []
for month in rainfall:
    if month[1] < 50:
        low_rainfall.append(month[0])
print("Months when the amount of rain was less than 50mm:\n", low_rainfall)
#~~~~~ELIN~~~~~~~



# Eesha 

Greater 
rainfall_greater = []
for x in rainfall:
	if x [0]>100:
		greater_than.append(I)
print(rainfall_greater)