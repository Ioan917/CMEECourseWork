### Abundances ###

library(ggplot2)
library(minpack.lm)

## Generate some data on the number of bacterial cells as a function of time

t <- seq(0, 22, 2)
N <- c(32500, 33000, 38000, 105000, 445000, 1430000, 3020000, 4720000, 5670000, 5870000, 5930000, 5940000)

set.seed(1234) # set seed to ensure you always get the same random sequence

data <- data.frame(t, N + rnorm(length(time), sd = .1)) # add some random error
# added a vector of normally distributed errors to emulate random sampling errors

names(data) <- c("Time", "N")

head(data)

# Plot these data

ggplot(data, aes(x = Time, y = N)) +
  geom_point(size = 3) +
  labs(x = "Time (Hours)", y = "Population size (cells)")

## Basic linear approach

# Log transforms the data and estimate by eye where growth looks exponential

data$LogN <- log(data$N)

# Visualize

ggplot(data, aes(x = t, y = LogN)) +
  geom_point(size = 3) +
  labs(x = "Time (Hours)", y = "log(cell number)")
# logged data looks fairly linear between hours 4 and 10

# use that time period to calculate the growth rate

(data[data$Time == 10,]$LogN - data[data$Time == 4,]$LogN) / (10 - 4) # 0.6046411
# our first, most basic estimate of r is 0.6

# Shouldn't take the data points directly, instead fit a linear model though 

lm_growth <- lm(LogN ~ Time, data = data[data$Time > 2 & data$Time < 12,])
summary(lm_growth) # 0.61638
# still not idea because we estimated exponential phase by eye
# do it better by iterating through different windows of points, comparing the 
# slopes and finding which the highest is to give the maximum growth rate rmax 
# - a rolling regression
# better still fit a more appropriate mathematical model using NLLS

## Fitting non-linear models for growth trajectories

# Define logistic model as a function object

logistic_model <- function(t, r_max, N_max, N_0) { # classic logistic equation
  return(N_0 * N_max * exp(r_max * t) / (N_max + N_0 * (exp(r_max * t) - 1)))
}

# Fit the model
# need some starting parameters for the model

N_0_start <- min(data$N)
N_max_start <- max(data$N)
r_max_start <- 0.62 # use out linear estimate from before

fit_logistic <- nlsLM(N ~ logistic_model(t = Time, r_max, N_max, N_0),
                     data,
                     list(r_max = r_max_start, N_0 = N_0_start, N_max = N_max_start))

summary(fit_logistic)

# Plot the fit

timepoints <- seq(0, 22, 0.1)

logistic_points <- logistic_model(t = timepoints, 
                                  r_max = coef(fit_logistic)["r_max"],
                                  N_max = coef(fit_logistic)["N_max"],
                                  N_0 = coef(fit_logistic)["N_0"])

df1 <- data.frame(timepoints, logistic_points)
df1$model <- "Logistic equation"
names(df1) <- c("Time", "N", "model")

ggplot(data, aes(x = Time, y = N)) +
  geom_point(size = 3) +
  geom_line(data = df1, aes(x = Time, y = N, col = model), size = 1) +
  theme(aspect.ratio = 1) + # make the plot square
  labs(x = "Time", y = "Cell number")

# What would this function look like on a log-transformed axis?

ggplot(data, aes(x = Time, y = LogN)) +
  geom_point(size = 3) +
  geom_line(data = df1, aes(x = Time, y = log(N), col = model), size = 1) +
  theme(aspect.ratio = 1) + # make the plot square
  labs(x = "Time", y = "log(Cell number)")
# model diverges from the data at the lower end
# logistic model assumes that the population is growing right from the start

## Fit the four growth models

gompertz_model <- function(t, r_max, N_max, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(log(N_max / N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/log(N_max / N_0) + 1)))
}

gompertz_model2 <- function(t, r_max, N_max, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(log(N_0) + (log(N_max) - log(N_0)) * exp(-exp(r_max * exp(1) * (t_lag - t)/((log(N_max) - log(N_0)) * log(10)) + 1)))
}

baranyi_model <- function(t, r_max, N_max, N_0, t_lag){  # Baranyi model (Baranyi 1993)
  return(N_max + log10((-1+exp(r_max*t_lag) + exp(r_max*t))/(exp(r_max*t) - 1 + exp(r_max*t_lag) * 10^(N_max-N_0))))
}

buchanan_model <- function(t, r_max, N_max, N_0, t_lag){ # Buchanan model - three phase logistic (Buchanan 1997)
  return(N_0 + (t >= t_lag) * (t <= (t_lag + (N_max - N_0) * log(10)/r_max)) * r_max * (t - t_lag)/log(10) + (t >= t_lag) * (t > (t_lag + (N_max - N_0) * log(10)/r_max)) * (N_max - N_0))
}

# Generate some starting values for the NLLS
# derive the starting values by using the actual data

N_0_start <- min(data$N)
N_max_start <- max(data$N)
t_lag_start <- data$Time[which.max(diff(diff(data$LogN)))]
r_max_start <- max(diff(data$LogN)) / mean(diff(data$Time))

# Fit the models

fit_logistic <- nlsLM(N ~ logistic_model(t = Time, r_max, N_max, N_0), data,
                      list(r_max=r_max_start, N_0=N_0_start, N_max=N_max_start))

fit_gompertz <- nlsLM(LogN ~ gompertz_model2(t = Time, r_max, N_max, N_0, t_lag), data,
                      list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, N_max = N_max_start))


#fit_baranyi <- nlsLM(LogN ~ baranyi_model(t = Time, r_max, N_max, N_0, t_lag), data,
#                      list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, N_max = N_max_start)) # Error
#
#fit_buchanan <- nlsLM(LogN ~ buchanan_model(t = Time, r_max, N_max, N_0, t_lag), data,
#                      list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, N_max = N_max_start)) # Error

 # Get the model summaries

summary(fit_logistic)
# summary(fit_baranyi)
# summary(fit_buchanan)
# summary(fit_gompertz)

# See how the fits work

timepoints <- seq(0, 24, 0.1)

logistic_points <- logistic_model(t = timepoints, r_max = coef(fit_logistic)["r_max"], N_max = coef(fit_logistic)["N_max"], N_0 = coef(fit_logistic)["N_0"])

#baranyi_points <- baranyi_model(t = timepoints, r_max = coef(fit_baranyi)["r_max"], N_max = coef(fit_baranyi)["N_max"], N_0 = coef(fit_baranyi)["N_0"], t_lag = coef(fit_baranyi)["t_lag"])

#buchanan_points <- buchanan_model(t = timepoints, r_max = coef(fit_buchanan)["r_max"], N_max = coef(fit_buchanan)["N_max"], N_0 = coef(fit_buchanan)["N_0"], t_lag = coef(fit_buchanan)["t_lag"])

gompertz_points <- gompertz_model(t = timepoints, r_max = coef(fit_gompertz)["r_max"], N_max = coef(fit_gompertz)["N_max"], N_0 = coef(fit_gompertz)["N_0"], t_lag = coef(fit_gompertz)["t_lag"])

df1 <- data.frame(timepoints, logistic_points)
df1$model <- "Logistic"
names(df1) <- c("t", "LogN", "model")

#df2 <- data.frame(timepoints, baranyi_points)
#df2$model <- "Baranyi"
#names(df2) <- c("t", "LogN", "model")

#df3 <- data.frame(timepoints, buchanan_points)
#df3$model <- "Buchanan"
#names(df3) <- c("t", "LogN", "model")

df4 <- data.frame(timepoints, gompertz_points)
df4$model <- "Gompertz"
names(df4) <- c("t", "LogN", "model")

model_frame <- rbind(df1, df4) # baranyi and buchanan cannot be fir to the 
# dataset that we're working with

ggplot(data, aes(x = t, y = LogN)) +
  geom_point(size = 3) +
  geom_line(data = model_frame, aes(x = t, y = LogN, col = model), size = 1) +
  theme_bw() + # make the background white
  theme(aspect.ratio=1)+ # make the plot square 
  labs(x = "Time", y = "log(Abundance)")
# Logistic does not fir as well as the gompertz
