#!/bin/bash
# Auhor: Ioan ie917@ic.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2020

BASE="${1%.*}"

if [[ -f $BASE.txt ]] && [[ "$#" = 1 ]] # checks if only 1 txt file selected
then
    echo "Creating a comma delimited version of $BASE.txt ..."
    cat $BASE.txt | tr -s "\t" "," >> $BASE.csv
    echo "Done!"
    exit
elif [[ ! -f $BASE.* ]] && [[ "$#" = 1 ]] # wrong file format
then
    echo "wrong file type"
elif [[ "$#" = 0  ]] # if no file selected
then
    echo "no file selected"
elif [[ "$#" -ne 1 ]] # if more than one file selected
then
    echo "only one file at a time please"
else # if anything else goes wrong
    echo "hit the books, something else went wrong"
fi
