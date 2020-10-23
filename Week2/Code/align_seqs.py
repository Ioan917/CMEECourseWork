#!/usr/bin/env python3

"""Python program that finds the best alignment of two DNA sequences 
and prints the best score and alignment to a txt file"""

__appname__ = '[application name here]'
__author__ = 'Ioan Evans (ie917@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

# Imports

import csv
import sys

## 1. Assigning to respective variables

def s1_longer(seq1, seq2):
    """Ensure each s1 and l1 correspond to the longer sequence and s2 and l2 to the shorter sequence"""
    l1 = len(seq1)
    l2 = len(seq2)
    
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1
    return s1, s2, l1, l2

## 2. Calculating number of matches

def calculate_score(s1, s2, l1, l2, startpoint):
    """Computes a score by returning the number of matches starting from an arbitrary startpoint (chosen by user)"""
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
    print("." * startpoint + matched)    
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ") # returns blank line

    return score, matched

## 3. Find the best match

def best_match(s1, s2, l1, l2):
    """Find the best match (highest score) for the two sequences"""
    my_best_align = None
    my_best_score = -1
    my_best_match = None

    for i in range(l1): # Note that you just take the last alignment with the highest score
        z, matched = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2
            my_best_score = z
            my_best_match = "." * i + matched

    # some formatted output
    print(my_best_match)    
    print(my_best_align)
    print(s1)
    print("Best score: " + str(my_best_score))
    print(" ") # returns blank line

    return my_best_align, my_best_score, my_best_match

## argv

def main(argv):

    # Open and read the inputted data file.
    f = open("../Data/TestSeq.csv", "r")
    f_read = csv.reader(f)
    
    # Prepare a .csv file for the next functions.
    for row in f_read:
        seq1 = row[0]
        seq2 = row[1]

    # Swab sequences to make s1 and l1 correspond to the longer sequence
    s1, s2, l1, l2 = s1_longer(seq1, seq2)

    # Find the best score i.e. best alignment between the two sequences
    my_best_align, my_best_score, my_best_match = best_match(s1, s2, l1, l2)

    # Output file
    g = open("../Results/Best_align.txt", "w")
    g.write(str(my_best_match) + "\n" + str(my_best_align) + "\n" + str(s1) + "\n" + "Best score: " + str(my_best_score))

    f.close() # Close input file
    g.close() # Close output file

    return 0
    
if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)


## Things to think about adding later

#    if [ len(sys.argv) == 2 ]:
#        f_read = open_read(sys.argv[1])
#        seq1, seq2 = prep()
#        s1, s2, l1, l2 = s1_longer()
#        score = calculate_score()
#        my_best_align, my_best_score = best_match()
#        output()
#    elif [ len(sys.argv) != 2 ]:
#        if [ len(sys.argv) == 1 ]:
#            print("No data file specified." + "\n" + "Using default alignment data.")
#            f_read = open_read()
#            seq1, seq2 = prep()
#            s1, s2, l1, l2 = s1_longer()
#            score = calculate_score()
#            my_best_align, my_best_score = best_match()
#            output()
#        else:
#            print("How? Isn't this impossible?")
#    else:
#        print("Something else went wrong")
#    return 0