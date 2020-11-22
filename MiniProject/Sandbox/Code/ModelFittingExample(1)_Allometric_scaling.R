### Model fitting in Ecology and Evolution ###

# Practice for the MiniProject

## Housekeeping

rm(list = ls())
graphics.off()

library(minpack.lm)
require("minpack.lm")

## Allometric scaling of traits

# Allometric relationship takes the form: y = a * x ^ b
# x = body length
# y = body weight

# Create a function object for the power law model

powMod <- function(x, a, b) {
  return(a * x ^ b)
}

## Load data

MyData <- read.csv("../Data/GenomeSize.csv")

# Inspect data

head(MyData)
# Anisoptera = dragonflies
# Zygoptera = damselflies
# Variables of interest = BodyWeight, TotalLength

# Subset data to remove NAs

Data2Fit <- subset(MyData, Suborder == "Anisoptera")
Data2Fit <- Data2Fit[!is.na(Data2Fit$TotalLength),]

# Visualise

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)

library(ggplot2)

ggplot(Data2Fit, aes(x = TotalLength, y = BodyWeight)) +
  geom_point(size = 3, color = "red") +
  theme_bw() +
  labs(y = "Body mass (mg)", x = "Wing length (mm)")

## Fit model to the data using NLLS

PowFit <- nlsLM(BodyWeight ~ powMod(TotalLength, a, b), 
                data = Data2Fit,
                start = list(a = .1, b = .1))
# a and b are best guesses

summary(PowFit)

# anova(PowFit) - returns an error - further stat inference cannot be done 
# using ANOVA

## Visualise the fit

# Generate a vector of body lengths for plotting

Lengths <- seq(min(Data2Fit$TotalLength), max(Data2Fit$TotalLength), len = 200)

# Calculate the predicted line
# Extract the coefficient from the model fit object using coef()

coef(PowFit)["a"]
coef(PowFit)["b"]

Predic2PlotPow <- powMod(Lengths, coef(PowFit)["a"], coef(PowFit)["b"])

# Plot the data and the fitted model line

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col = "blue", lwd = 2.5)

## Calculate confidence intervals on the estimated parameters
#  as we would in OLS fitting used for Linear Models

confint(PowFit)
# statistically significant if CI does not include 0 - different from 0

### Comparing models
# run an alternative model to compare with existing model

## Try a quadratic curve: y = a + bx + cx^2

QuaFit <- lm(BodyWeight ~ poly(TotalLength, 2), data = Data2Fit)

# Obtain predicted values - this time using predict.lm

Predic2PlotQua <- predict.lm(QuaFit, data.frame(TotalLength = Lengths))

## Plot 2 fitted models together

plot(Data2Fit$TotalLength, Data2Fit$BodyWeight)
lines(Lengths, Predic2PlotPow, col = "blue", lwd = 2.5)
lines(Lengths, Predic2PlotQua, col = "red", lwd = 2.5)

## Formal model comparison to check which model better fits the data

# Calculate R^2 values of the 2 fitted models

RSS_Pow <- sum(residuals(PowFit)^2) # residual sum of squares
TSS_Pow <- sum((Data2Fit$BodyWeight - mean(Data2Fit$BodyWeight))^2) # total sum of squares
RSq_Pow <- 1 - (RSS_Pow / TSS_Pow) # R-squared value

RSS_Qua <- sum(residuals(QuaFit)^2) # residual sum of squares
TSS_Qua <- sum((Data2Fit$BodyWeight - mean(Data2Fit$BodyWeight))^2) # total sum of squares
RSq_Qua <- 1 - (RSS_Qua / TSS_Qua) # R-squared value

RSq_Pow # 0.9005475
RSq_Qua # 0.9003029
# not very useful
# R^" is a good measure of model fit but cannot be used for model selection 
# given tiny differences

# Use Akaike Information Criterion (AIC)

n <- nrow(Data2Fit) # set sample size
pPow <- length(coef(PowFit)) # get number of parameters in power law model
pQua <- length(coef(QuaFit)) # get number of parameters in quadratic model

AIC_Pow <- n + 2 + n * log((2 * pi) / n) + n * log(RSS_Pow) + 2 * pPow
AIC_Qua <- n + 2 + n * log((2 * pi) / n) + n * log(RSS_Qua) + 2 * pQua

AIC_Pow - AIC_Qua # -2.147426

# Use in-built function

AIC(PowFit) - AIC(QuaFit) # -2.147426
# AIC value difference of > 2 is an acceptable cutoff for calling a winner
# The better model has a lower AIC, Power model is better