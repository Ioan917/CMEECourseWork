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