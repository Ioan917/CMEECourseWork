#!/usr/bin/env python3

"""Run the LV scripts, print the standard output to the console and profile the scripts."""

import subprocess

## Run LV scripts
p = subprocess.Popen(["python3", "LV1.py"], 
        stdout = subprocess.PIPE, 
        stderr = subprocess.PIPE)
stdout, stderr = p.communicate()

print(stdout.decode())

q = subprocess.Popen(["python3", "LV2.py", "1", "0.2", "0.5", "0.5", "50"], 
        stdout = subprocess.PIPE, 
        stderr = subprocess.PIPE)
stdout, stderr = q.communicate()

print(stdout.decode())

subprocess.os.system("python3 -m cProfile LV1.py 1 0.2 0.5 0.5 50")
subprocess.os.system("python3 -m cProfile LV2.py 1 0.2 0.5 0.5 50")