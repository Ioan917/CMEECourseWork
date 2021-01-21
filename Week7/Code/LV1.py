#!/usr/bin/env python3

"""Defining and plotting the Lotka-Volterra model of population dynamics for provided parameters."""

__appname__ = 'LV1.py'
__author__ = 'Ioan Evans'
__email__ = 'ie917@ic.ac.uk'
__version__ = '0.0.1'
__license__ = "License for this code/program"

### The Lotka-Volterra model

## Imports
import matplotlib.pylab as p
import numpy as np
import scipy.integrate as integrate
import sys
import time
import timeit

## Define the function
def dCR_dt(pops, r=1., a=0.1, z=1.5, e=0.75, t=0):
    """Lotka-Volterra model of population dynamics between consumer and resource populations."""
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return np.array([dRdt, dCdt])

def main(argv):
    """Main function: runs Lotka-Volterra model and plots results, saving to pdf"""
    ## Profile pt1
    startTime = time.time()

    ## Assign some parameter values
    r = 1.
    a = 0.1 
    z = 1.5
    e = 0.75

    ## Define the time vector
    t = np.linspace(0, 15, 1000)

    ## Set the initial conditions for the two populations
    R0 = 10
    C0 = 5 
    RC0 = np.array([R0, C0])

    ## Numerically integrate this system forward from those starting conditions
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

    f1 = p.figure()
    p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
    p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
    p.grid()
    p.legend(loc='best')
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-Resource population dynamics')

    f1.savefig('../Results/LV1_model1.pdf') #Save figure


    f2 = p.figure()
    p.plot(pops[:,0], pops[:,1], 'r-') # Plot
    p.grid()
    p.xlabel('Resource density')
    p.ylabel('Consumer density')
    p.title('Consumer-Resource population dynamics')

    f2.savefig('../Results/LV1_model2.pdf') #Save figure

    ## Profile pt2
    executionTime = (time.time() - startTime)
    print('LV1.py execution time in seconds: ' + str(round(executionTime, 3)) + ".")
    
    return 0

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)