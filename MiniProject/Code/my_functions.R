#!/usr/bin/env Rscript --vanilla

# Title: my_functions.R
# Author details: Author: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Jan 2020
# Script and data info: Homemade functions for the mini-project.
# Copyright statement: none

################################################################################
######################## THE MODELS TO FIT TO THE DATA #########################
################################################################################

################################ LINEAR MODELS #################################
# Phenomenological
# Fitted and plotted using lm() function

# Quadratic
# Cubic

############################## NON-LINEAR MODELS ###############################
# Mechanistic

## Type I
HollModI <- function(xR,
                      a) {
  return ( a * xR )
}

## Type II
HollModII <- function(xR,
                       a,
                       h) {
  return ( (a * xR) / (1 + (h * a * xR) ) )
}

## Type III
HollModIII <- function(xR,
                        a,
                        h) {
  return ( (a * (xR ^ 2)) / (1 + (h * a * (xR ^ 2)) ) )
}
# response variable = consumption rate (c)
# expressed in terms of biomass quantity or number of individuals of resource 
# consumed per unit time per unit consumer

## Generalised functional model
GenFunMod <- function(a, 
                      xR, 
                      h,
                      q) {
  n <- q + 1
  return ( (a * xR ^ (n) ) / (1 + (h * a * xR ^ (n) ) ) )
}
# less mechanistic because of the phenomenological parameter q (no biological 
# meaning)

################################################################################
####################### DEFINE THE BETTER FITTING MODEL ########################
################################################################################

## Calculate the difference in AICc and BIC between the two models
## Add this as a new column
## Write a new column that states the best fit model for each subset

define_winner <- function(dataframe,
                          column_one, column_two, 
                          model_one, model_two,
                          new_column) {
  
  ## Add winner column
  
  ## Calculate difference
  diff <- column_one - column_two

  ## Define winner Quadratic vs Cubic
  
  # if difference > 2 winner = second input number
  # elseif difference < -2 winner = first input number
  # if difference > 2 winner = second input number
  # if +inf = first input number
  # if -inf = second input number
  
  ## Winner
  dataframe[, new_column] <- ifelse(diff > 2,  model_two,
                             ifelse(diff < -2, model_one,
                                              "Draw"))
  
  return(dataframe)
}

################################################################################
############################### PAIRWISE WINNER ################################ 
################################################################################

pairwise_wins <- function(dataframe, current_col_no) {
  
  models <- c("StraightLine",
              "Quadratic",
              "Cubic",
              "TypeI",
              "TypeII",
              "TypeIII",
              "General")
  
  if (current_col_no == 1) {
    current_model <- "StraightLine"
  } else if (current_col_no == 2) {
    current_model <- "Quadratic"
  } else if (current_col_no == 3) {
    current_model <- "Cubic"
  } else if (current_col_no == 4) {
    current_model <- "TypeI"
  } else if (current_col_no == 5) {
    current_model <- "TypeII"
  } else if (current_col_no == 6) {
    current_model <- "TypeIII"
  } else if (current_col_no == 7) {
    current_model <- "General"
  }
  
  list <- rep(0, 7)

  for (i in 1:7) {
    diff <- dataframe[,current_col_no] - dataframe[,i]
    
    winner <- ifelse(diff > 2,  models[i],
              ifelse(diff < -2, current_model,
                                "Draw"))
    
    list[i] <- round(100 * sum(winner == current_model) / length(winner), 3)
  }
  
  table_df <- rbind(table_df, list)
  
  return(table_df)
}

################################################################################
####################### FUNCTION FOR SUMMARY STATISTICS ########################
################################################################################

data_summary <- function(x) {
  
  m <- mean(x)
  ymin <- m-sd(x)
  ymax <- m+sd(x)
  
  return(c(y=m,ymin=ymin,ymax=ymax))
}
