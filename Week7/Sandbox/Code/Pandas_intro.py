import pandas as pd
pd.__version__

import scipy as sc

## Importing data
MyDF = pd.read_csv("../Data/testcsv.csv", sep = ",")
MyDF

## Creating dataframes
MyDF = pd.DataFrame({
    "col1": ["Var1", "Var2", "Var3", "Var4"],
    "col2": ["Grass", "Rabbit", "Fox", "Wolf"],
    "col3": [1, 2, sc.nan, 4]
})
MyDF

## Examining your data
# top 5 rows
MyDF.head()

# bottom 5 rows
MyDF.tail()

# dimensions
MyDF.shape

# number of rows
len(MyDF)

# array of the column names
MyDF.columns

# columns and their types
MyDF.dtypes

# converts df to a 2-D table
MyDF.values

# descriptive stats for all columns
MyDF.describe