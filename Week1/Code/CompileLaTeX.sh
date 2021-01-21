#!/bin/bash
# Author: Ioan ie917@ic.ac.uk
# Script: CompileLaTeX.sh
# Desc: Compile LaTeX script into pdf file.
# Arguments: LaTeX (.tex) script e.g. bash CompileLaTeX.sh <file.tex>
# Date Oct 2020

#!/bin/bash
BASE="${1%.*}"
pdflatex $BASE.tex
bibtex $BASE
pdflatex $BASE.tex
pdflatex $BASE.tex
evince $BASE.pdf &

## Cleanup
#rm *~
#rm *.aux
#rm *.dvi
#rm *.log
#rm *.nav
#rm *.out
#rm *.snm
#rm *.toc

rm -f {*~,*.aux,*.bbl,*.blg,*.dvi,*.log,*.nav,*.out,*.snm,*.toc}

exit