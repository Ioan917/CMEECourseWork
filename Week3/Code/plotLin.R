#!/usr/bin/env Rscript --vanilla

# Title: plotLin.R
# Author details: Ioan Evans, Contact details: ie917@ic.ac.uk
# Date: Nov 2020
# Script and data info: Example mathematical annotation on an axis and in the plot area.
# Copyright statement: none

## Housekeeping
rm(list = ls())
graphics.off()

## Load packages
require(ggplot2)

## Create some linear regression data
x <- seq(0, 100, by = 0.1)
y <- -4. + 0.25 * x + rnorm(length(x), mean = 0., sd = 2.5)

## Put the data in a dataframe
my_data <- data.frame(x = x, y = y)

## Perform linear regression
my_lm <- summary(lm(y ~ x, data = my_data))

## Plot the data
p <- ggplot(my_data, aes(x = x, y = y, colour = abs(my_lm$residual))) +
  geom_point() +
  scale_colour_gradient(low = "black", high = "red") +
  theme(legend.position = "none") +
  scale_x_continuous(expression(alpha^2 * pi / beta * sqrt(Theta)))

## Add the regression line
p <- p + geom_abline(intercept = my_lm$coefficients[1][1],
                     slope = my_lm$coefficients[2][1],
                     colour = "red")

## Throw some maths on the plot
p <- p + geom_text(aes(x = 60, y = 0,
                       label = "sqrt(alpha) * 2 * pi"),
                   parse = TRUE, 
                   size = 6,
                   colour = "blue")

## Exporting as pdf
pdf("../Results/MyLinReg.pdf")
print(p)
dev.off()

print("Script done!")