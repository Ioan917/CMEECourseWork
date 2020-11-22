#!/usr/bin/env python3

import subprocess

try:
    subprocess.Popen("Rscript --verbose fmr.R > ../Results/fmr_plot.pdf 2> ../Results/fmr_errFile.Rout", shell = True).wait()
    print("Script run successfully!")
except:
    print("Generic error message.")