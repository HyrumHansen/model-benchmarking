# y is the response variable. 2000 total observations in this dataset.
num_classes <- 4
obs_per_class <- 500

y <- sort(rep(c(1:num_classes), obs_per_class))

# x0, a near perfect predictor of y.
x0 <- c(rnorm(500, mean = 5, sd = 1),
        rnorm(500, mean = 10, sd = 1),
        rnorm(500, mean = 15, sd = 1),
        rnorm(500, mean = 20, sd = 1))

# x1, a really good predictor of y.
x1 <- c(rnorm(500, mean = 5, sd = 2.5),
        rnorm(500, mean = 10, sd = 2.5),
        rnorm(500, mean = 15, sd = 2.5),
        rnorm(500, mean = 20, sd = 2.5))

# x2, an okay predictor of y
x2 <- c(rnorm(500, mean = 5, sd = 4),
        rnorm(500, mean = 10, sd = 4),
        rnorm(500, mean = 15, sd = 4),
        rnorm(500, mean = 20, sd = 4))

# x3, a variable that's nothing but noise
x3 <- c(rnorm(2000, mean = 10, sd = 10))

classification_data <- data.frame(y, x0, x1, x2, x3)

write.csv(classification_data, "data/classification_data.csv")
