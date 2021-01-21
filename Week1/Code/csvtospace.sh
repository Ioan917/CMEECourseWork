#!/bin/bash
# Author: Ioan ie917@ic.ac.uk
# Script: csvtospace.sh
# Desc: Substitute commas was spaces.
# Arguments: A .csv file e.g. csvtospace.sh <file.csv>
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

exit