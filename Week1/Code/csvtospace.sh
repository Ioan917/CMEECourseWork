#!/bin/bash
# Auhor: Ioan ie917@ic.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .txt file
# Arguments: 1 -> tab delimited file
# Date: Oct 2020

BASE="${1%.*}"

if [[ -f $BASE.csv ]] && [[ "$#" = 1 ]] 
then
    echo "Creating a space delimited version of $BASE.csv ..."
    cat $BASE.csv | tr -s "," " " >> $BASE.txt
    echo "Done!"
    exit
elif [[ ! -f $BASE.csv ]] && [[ "$#" = 1 ]] 
then
    echo "incorrect file type"
elif [[ "$#" = 0 ]]
then
    echo "no files selected"
elif [[ "$#" != 1 ]]
then
    echo "only one input file please"
else
    echo "something else went wrong"
fi