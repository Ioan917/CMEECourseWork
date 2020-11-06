#!/usr/bin/env R

## Load data

data <- load("../Data/KeyWestAnnualMeanTemperature.RData")

## Examine data

#plot(ats$Temp ~ ats$Year,
#     xlab = "Year",
#     ylab = "Temperature °C",
#     cex.axis = 1.3,
#     cex.lab = 1.4)

## Compute the correlation coefficient between successive years and store it
## cor()

corr_1 <- cor(ats$Temp[-100], ats$Temp[-1]) #  0.3261697

#plot(ats$Temp[-100], ats$Temp[-1],
#     xlab = "Temperature (°C) at t",
#     ylab = "Temperature (°C) at t-1")
#abline(lm(ats$Temp[-1] ~ ats$Temp[-100]), lty = "dotted")

# Alternatively using the acf function

# acf(ats$Temp, lag.max = 10, plot = FALSE)

# Repeat the calculation 10,000 times by randomly permuting the time series and 
# then recalculating the correlation coefficient for each randomly permuted year 
# sequence and storing it
# use sample function

corr_dist <- replicate(10000, {
  permute <- sample(ats$Temp)
  corr <- cor(permute[-100], permute[-1])
})

#plot(density(corr_dist),
#     xlab = "Correlation of permuted data",
#     ylab = "Density",
#     main = "") # normally distributed
#abline(v = 0.3261697, lty = "dotted")

# Calculate what fraction of the correlation coefficients from the previous step 
# were greater than that from step 1 - appropriate p-value

pvalue <- sum(corr_dist > corr_1) / length(corr_dist)

print(paste("t and t-1 have a correlation of ", as.character(signif(corr_1, digits = 3)), 
            ", which returns a p-value of ", as.character(pvalue), sep = ""))

print("Script done!")