### Albatross chick growth ###

alb <- read.csv(file = "../Data/albatross_grow.csv")
alb <- subset(x = alb, !is.na(alb$wt))

plot(alb$age, alb$wt, xlab = "age (days)", ylab = "weight (g)", xlim = c(0, 100))

## Fitting 3 models using NLLS
# 1. Von Bertalanffy model - growth of an individual
# 2. Classical logistic growth equation
# 3. Straight line

## Define R functions for the 2 models

vonbert.w <- function(t, Winf, c, K) {
  Winf * (1 - exp(-K * t) + c * exp(-K * t)) ^ 3
}

logistic1 <- function(t, r, K, N0) {
  N0 * K * exp(r * t) / (K + N0 * (exp(r * t) - 1))
}

# use lm for straight line model

# Scale the data before fitting to improve stability of estimates

scale <- 4000

alb.vb <- nlsLM(wt / scale ~ vonbert.w(age, Winf, c, K),
                start = list(Winf = 0.75, c = 0.01, K = 0.01),
                data = alb)

alb.log <- nlsLM(wt / scale ~ logistic1(age, r, K, N0), 
                 start = list(K = 1, r = 0.1, N0 = 0.1),
                 data = alb)

alb.lin <- lm(wt / scale ~ age, data = alb)

# Calculate predictions for each of the models across a range of ages

ages <- seq(0, 100, length = 1000)

pred.vb <- predict(alb.vb, newdata = list(age = ages)) * scale

pred.log <- predict(alb.log, newdata = list(age = ages)) * scale

pred.lin <- predict(alb.lin, newdata = list(age = ages)) * scale

# Plot the data with the fits

plot(alb$age, alb$wt, xlab = "age (days)", ylab = "weight (g)", xlim = c(0, 100))
lines(ages, pred.vb, col = 4, lwd = 2)
lines(ages, pred.log, col = 3, lwd = 2)
lines(ages, pred.lin, col = 2, lwd = 2)

legend("topleft", legend = c( "linear", "logistic", "Von Bert"), lwd = 2, lty = 1, col = 2:4)

# Examine residuals between the 3 models

par(mfrow = c(3, 1), bty = "n")
plot(alb$age, resid(alb.vb), main = "VB resids", xlim = c(0, 100))
plot(alb$age, resid(alb.log), main = "Logistic resids", xlim = c(0, 100))
plot(alb$age, resid(alb.lin), main = "LM resids", xlim = c(0, 100))
# residuals for all 3 models still exhibit some patterns
# none of the models can capture the behaviour of going down near the end of 
# observation period

# Compare the 3 models by calculating Sum of Squared Errors (SSEs)
# simpler than AIC / BIC, less robust

n <- length(alb$wt)
list(vb = signif(sum(resid(alb.vb) ^ 2) / (n - 2 * 2), 3), # 0.00614
     log = signif(sum(resid(alb.log) ^ 2) / (n - 2 * 2), 3), # 0.00548
     lin = signif(sum(resid(alb.lin) ^ 2) / (n - 2 * 2), 3)) # 0.00958
# SSE accounts for sample size and number of parameters by dividing RSS by 
# residual df (residual df = number of response values (sample size, n) minus 2, 
# multiplied by the number of fitted coefficients m (2 or 3 in this case))
# logistic model has lowest adjusted SSE - best model by this measure