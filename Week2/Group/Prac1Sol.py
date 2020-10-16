#Danica
#ls1.py
#(1)
Latin_names = [x for x, y, z in birds]
Common_names = [y for x, y, z in birds]
Mean_body_masses = [z for x, y, z in birds]
print(Latin_names)
print(Common_names)
print(Mean_body_masses)

#(2)
Latin_names = []
Common_names = []
Mean_body_masses = []
for x, y, z in birds:
    Latin_names.append(x)
    Common_names.append(y)
    Mean_body_masses.append(z)
print(Latin_names)
print(Common_names)
print(Mean_body_masses)
#Danica


##Eesha 
latin_names = [i[0] for i in birds]
common_names = [i[1] for i in birds]
body_masses = [i[2] for i in birds]

print("Latin names:", str(latin_names))
print("Common names:", str(common_names))
print("Body Masses:", str(body_masses))


#~~~~~ELIN~~~~~~
print("LIST COMPREHENSIONS")

#Print latin names of species in birds database (list comprehension)
latin_names = [row[0] for row in birds]
print("Latin names:\n", latin_names)

#Print common names of species in birds database (list comprehension)
common_names = [row[1] for row in birds]
print("Common names:\n", common_names)

#Print mean body masses of species in birds database (list comprehension)
body_masses = [row[2] for row in birds]
print("Mean body masses:\n", body_masses)

#Print new line to separate list comprehensions and for loops
print("\n")

#############################

print("FOR LOOPS")

#Print latin names of species in birds database (for loop)
latin_names = []
for row in birds:
    latin_names.append(row[0])
print("Latin names:\n", latin_names)

#Print common names of species in birds database (for loop)
common_names = []
for row in birds:
  common_names.append(row[1])
print("Common names:\n", common_names)

#Print mean body masses of species in birds database (for loop)
body_masses = []
for row in birds:
    body_masses.append(row[2])
print("Mean body masses:\n", body_masses)
#~~~~~ELIN~~~~~~


### IOAN ###

# List comprehension

## Latin names

latin_names = [i[0] for i in birds]
print(latin_names)

## Common names

common_names = [i[1] for i in birds]
print(common_names)

## Body masses

body_masses = [i[2] for i in birds]
print(body_masses)

# Loops

## Latin names

latin_loops = []
for i in birds:
    latin_loops.append(i[0])
print(latin_loops)

## Common names

common_loops = []
for i in birds:
    common_loops.append(i[1])
print(common_loops)

## Body masses

mass_loops = []
for i in birds:
    mass_loops.append(i[2])
print(mass_loops)

### Ioan ###