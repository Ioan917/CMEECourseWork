### D ata exploration for Mini-project
### Functional responses

## Import modules
import matplotlib.pylab as mat
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

## Load data
data = pd.read_csv("../Data/CRat.csv")
# Based on instructions the 2 main fields of interest are:
#   N_TraitValue - number of resources consumed per consumer per unit time
#   ResDensity - resource abundance

# Individual response curves identified by ID values
# each ID corresponds to 1 curve
#   or, reconstruct as: 
#       unique combinations of Citations - where functional response dataset came from
#       ConTaxa - consumer species ID
#       ResTaxa - resource species ID

print("Loaded {} columns.".format(len(data.columns.values)))

data.head()

#print(data.columns.values)

#print(data.TraitUnit.unique())

#print(data.ResDensityUnit.unique())

#print(data.ID.unique())

#data_subset = data[data['ID'] == 39982]
#data_subset.head()

## Visualise data
sns.lmplot("ResDensity", "N_TraitValue", data = data_subset, fit_reg = False)
plt.show()

## The models
