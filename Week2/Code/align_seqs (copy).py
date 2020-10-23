## make each block into single functions
## list each function under the main()

#!/usr/bin/env python3

"""Python program that finds the best alignment of two DNA sequences 
and prints the best score and alignment to a txt file"""

__appname__ = '[application name here]'
__author__ = 'Ioan Evans (ie917@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

# Imports

import csv
import ipdb
import sys

# Importing data

# Input

f = open('../Data/TestSeq.csv', 'r') # ?_io.TextIOWrapper

f_read = csv.reader(f) # once opened, need to read the file in order to access it

for row in f_read:
    seq1 = row[0]
    seq2 = row[1]

f.close()

# Ensure that s1 and l1 correspond to the longer sequence and
            # s2 and l2 correspond to the shorter sequence

seq2 = "ATCGCCGGATTACGGG"
seq1 = "CAATTCGGAT"

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1: # the startpoint must be less than the length of the longer sequence
            if s1[startpoint + i] == s2[i]: # if the bases match
                matched = matched + "*" # add "*" to the new string to indicate match
                score = score + 1
            else:
                matched = matched + "-" # add "-" to the new string to indicate no match

    # some formatted output
    print("." * startpoint + matched) # "." * startpoint is printing e.g. ..... if the startpoint is 5 - shouldn't this be .... if the startpoint is 5???      
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ") # returns blank line

    return score

# Test the function with some example starting points:
calculate_score(s1, s2, l1, l2, 0)
calculate_score(s1, s2, l1, l2, 1)
calculate_score(s1, s2, l1, l2, 5)

# Find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2
        my_best_score = z 

## Output

def output():
    g = open("../Results/Best_align.txt", "w")
    g.write(str(my_best_align) + "\n" + str(s1) + "\n" + "Best score: " + str(my_best_score))
    sys.stdout = open("../Results/Best_align_result.txt", "w")

### argv ###

def main(argv):
    if [ len(sys.argv) == 2 ]:
        # run above code
    elif [ len(sys.argv) != 2 ]:
        if [ len(sys.argv) == 1 ]:
            f = open('../Data/TestSeq.csv', 'r')
            print("No data file specified." + "\n" + "Using default data file.")
        else [ len(sys.argv) == 0]:
            print("How? Isn't this impossible?")
    else:
        print("Something else went wrong")
    return 0

    output(sys.argv[1])
    
if __name__ == "__main__":
    status = main(sys.argv)
    print('This program is being run by itself')
else:
    print('I am being imported from another module')
    sys.exit(status)