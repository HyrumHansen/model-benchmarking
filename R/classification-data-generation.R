# y is the response variable. 2000 total observations in this dataset.
num_classes <- 4
obs_per_class <- 20000

y <- sort(rep(c(1:num_classes), obs_per_class))

# x1, a really good predictor of y.
x1 <- c(rnorm(obs_per_class, mean = 5, sd = 2),
        rnorm(obs_per_class, mean = 10, sd = 2),
        rnorm(obs_per_class, mean = 15, sd = 2),
        rnorm(obs_per_class, mean = 20, sd = 2))

# x2, an okay predictor of y
x2 <- c(rnorm(obs_per_class, mean = 5, sd = 4),
        rnorm(obs_per_class, mean = 10, sd = 4),
        rnorm(obs_per_class, mean = 15, sd = 4),
        rnorm(obs_per_class, mean = 20, sd = 4))

# x3, a variable that's nothing but noise
x3 <- c(rnorm(num_classes*obs_per_class, mean = 10, sd = 10))

classification_data <- data.frame(y, x1, x2, x3)

write.csv(classification_data, "data/classification_data.csv")
