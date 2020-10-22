#!/usr/bin/env python3

"""Writing conventional loops and list comprehensions to perform the same function."""

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

### List Comprehensions ###

## Latin names

latin_names = [i[0] for i in birds]
print(latin_names)

## Common names

common_names = [i[1] for i in birds]
print(common_names)

## Body masses

body_masses = [i[2] for i in birds]
print(body_masses)

### Conventional Loops ###

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