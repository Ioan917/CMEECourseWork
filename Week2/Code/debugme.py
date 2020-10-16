def makeabug(x):
    y = x**4
    z = 0.
    y = y/z # ZeroDivisionError: float division by zero
    return y

makeabug(25)

## To debug function
# %pdb
# %run debugme.py

# Alternatively, run the code in ipython with ruun -d flag

## Paranoid programming
# import ipdb; ipdb.set_trace()
# insert the above code to pause the program to and inspect a given line or block of code
