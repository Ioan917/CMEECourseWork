### Numerical computing in python
## Numpy arrays
import numpy as np

a = np.array(range(5)) # one-dimensional array
a

print(type(a))
print(type(a[0])) # numpy arrays include float numbers by default
# type here is integer because we used the range function (which 
# returns integers)

# Specify the data type of the array
a = np.array(range(5), float)
a

a.dtype # check type

# 1-D array
x = np.arange(5)
x

# Directly specify float using decimal
x = np.arange(5.)
x

# See dimension of x
x.shape

# Convert to and from python lists
b = np.array([i for i in range(10) if i % 2 == 1]) # odd numbers between 1 and 10
b

c = b.tolist() # convert back to list
c

# Need a 2-D numpy array to make a matrix
mat = np.array([[0, 1], [2, 3]])
mat

mat.shape

## Indexing and accessing arrays
mat[1] # accessing whole 2nd row (indexing starts at 0)
mat[:, 1] # accessing whole second column
mat[:, 0] # accessing whole first column
# accessing particular elements
mat[0, 0] # 1st row, 1st column element
mat[1, 0] # 2nd row, 1st column element
# python indexing also accepts negative values
# interesting but useless for simple matrix
mat[0, 1]
mat[0, -1]
mat[-1, 0]
mat[0, -2]

## Manipulating arrays

# Replacing, adding or deleting elements
mat[0,0] = -1 # replace a single element
mat

mat[:,0] = [12,12] # replace whole column
mat

sc.append(mat, [[12,12]], axis = 0) # append row (note axis specification)

sc.append(mat, [[12],[12]], axis = 1) # append column

newRow = [[12,12]] # create new row
mat = np.append(mat, newRow, axis = 0) # append that existing row
mat

sc.delete(mat, 2, 0) # delete 3rd row

mat = np.array([[0,1], [2,3]])
mat0 = np.array([[0,10], [-1,3]])
sc.concatenate((mat, mat0), axis = 0) # concatenate

# Flattening or reshaping arrays
# i.e. change array dimensions
# e.g. from a matrix to a vector
mat.ravel()
mat.reshape((4,1))
mat.reshape((1,4))
mat.reshape((3,1)) # total elements must remain the same

## Pre-allocating arrays
# Initialise with 1s and 0s
np.ones((4,2)) # (4,2) are the (row,col) array dimensions
np.zeros((4,2)) # or 0s
# Create an identity matrix
m = sc.identity(4) # create an identity matrix
m

m.fill(16) # fill the matrix with 16
m

## numpy matrices
# Matrix-vector operations
mm = np.arange(16)
mm = mm.reshape(4,4) # Convert to matrix
mm

mm.transpose()

mm + mm.transpose()

mm - mm.transpose()

mm * mm.transpose() # element-wise multiplication

mm // mm.transpose() # integer division
# returns warning due to division by 0

mm // (mm + 1).transpose() # avoid the divide by 0

mm * np.pi

mm.dot(mm) # dot product

mm = np.matrix(mm) # convert to numpy matrix class
mm
print(type(mm))
# makes matrix multiplication syntactically easier
mm * mm # instead of mm.dot(mm)
# not recommended that you use the numpy matrix class 
# because it may be removed in future

## Two particularly useful scipy sub-packages
# sc.integrate
# sc.stats

# Scipy stats
import scipy.stats

scipy.stats.norm.rvs(size = 10) # 10 samples from N(0,1)
scipy.stats.randint.rvs(0, 10, size = 7) # random integers between 0 and 10

# Numerical integration using scipy
## The Lotka-Colterra model

# Import scipy's integrate submodule
import scipy.integrate as integrate

# Define a function that returns the growth rate of consumer and resource
# population at any given time step
def dCR_dt(pops, t=0):

    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C
    dCdt = -z * C + e * a * R * C

    return sc.array([dRdt, dCdt])

type(dCR_dt)

# Assign some parameter values
r = 1.
a = 0.1
z = 1.5
e = 0.75

# Define the time vector
# integrate from time point 0 to 15, using 1000 
# sub-divisions of time (arbitrary units of time)
t = sc.linspace(0, 15, 1000)

# Set the initial conditions for the 2 populations
R0 = 10
C0 = 5
RC0 = sc.array([R0, C0]) # dCR_dt takes array as input

# Numerically integrate this system forward from those 
# starting values
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output = True)
pops # contains poplation trajectories
type(infodict) # dictionary with additional information
infodict.keys()
infodict["message"] # returns message to screen about whether 
# the integration was successful

## Visualise the results
# using matplotlib
import matplotlib.pylab as p

# Open an empty figure object
f1 = p.figure()

p.plot(t, pops[:,0], "g-", label = "Resource density") # Plot
p.plot(t, pops[:,1], "b-", label = "Consumer density")
p.grid()
p.legend(loc = "best")
p.xlabel("Time")
p.ylabel("Population density")
p.title("Consumer-Resource population dynamics")
p.show() # Display figure
f1.savefig("../Results/LV_model.pdf") # Save figure