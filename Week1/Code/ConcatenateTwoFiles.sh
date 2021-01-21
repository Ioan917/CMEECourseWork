#!/bin/bash
# Author: Ioan ie917@ic.ac.uk
# Script: ConcatenateTwoFiles.sh
# Desc: Concatenate two files.
# Arguments: Two text files as inputs and one text file as output e.g. bash ConcatenateTwoFiles.sh <input1.txt> <input2.txt> <output.txt>
# Date: Oct 2020

if [[ "$#" = 3 ]] # if a perfect 3 files selected
then
    cat $1 > $3
    cat $2 >> $3
    echo "Merged File is"
    cat $3
elif [[ "$#" = 0 ]]
then
    echo "no files selected"
elif [[ "$#" != 3 ]] # if greater than or fewer than 3 files selected
then
    echo "write 3 file names please (2 for input and 1 for output)"
else # some other error, not specified above
    echo "something else went wrong"
fi

exit