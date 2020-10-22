# This function calculates heights of trees given distance of each tree
# from its base and angle to its top, using the trigonometric formula
# 
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees: The angle of elevation of tree
# distance: The distance from base of tree (e.g. meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

# Loading data

tree_data <- read.csv("../Data/trees.csv")

# Function

TreeHeight <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    
    return(height)
}

# Assigning the output of the function to a column

tree_data$Tree.Height.m <- TreeHeight(tree_data$Angle.degrees, tree_data$Distance.m)

# Creating a csv output

write.csv(tree_data, "../Results/TreeHts.csv", row.names = FALSE)

# Message to state complete

print("Done")