library(keras)
library(dplyr)

# load the example dataset "data" which has 4 predictors and 3 classes
set.seed(1234)
data <- read.csv("data/regression_data.csv")
data <- data[sample(1:nrow(data)), ]
n_obs <- nrow(data)

# Prepare the dataset
x_train <- as.matrix(data[1:1500, c(2:5)])
y_train <- as.matrix(data[1:1500, 1])
x_test <- as.matrix(data[1501:n_obs, c(2:5)])
y_test <- as.matrix(data[1501:n_obs, 1])

# Define the neural network architecture
model <- keras_model_sequential() %>%
  layer_dense(units = 128, activation = "relu", input_shape=4) %>%
  layer_dense(units = 64, activation = "relu") %>%
  layer_dense(units = 32, activation = "relu") %>%
  layer_dense(units = 1)

class(x_train)

# Compile the model
model %>% compile(
  loss = "mse",
  optimizer = "adam",
  metrics = list("mean_squared_error")
)

model %>% summary()

# Train the model
history <- model %>% fit(
  x_train, y_train,
  epochs = 100
)

# Initialize an empty vector to store the fit times
fit_times <- numeric()

# Loop over 50 iterations and fit the decision tree model
for (i in 1:50) {
  # Record the start time
  t0 <- Sys.time()

  # Define the neural network architecture
  model <- keras_model_sequential() %>%
    layer_dense(units = 128, activation = "relu", input_shape=4) %>%
    layer_dense(units = 64, activation = "relu") %>%
    layer_dense(units = 32, activation = "relu") %>%
    layer_dense(units = 1)

  # Compile the model
  model %>% compile(
    loss = "mse",
    optimizer = "adam",
    metrics = list("mean_squared_error")
  )

  # Train the model
  history <- model %>% fit(
    x_train, y_train,
    epochs = 8
  )

  # Record the end time
  t1 <- Sys.time()

  # Calculate the fit time and append it to the fit_times vector
  fit_time <- as.numeric(difftime(t1, t0, units = "secs"))
  fit_times <- c(fit_times, fit_time)
}

# Calculate the total time, median time, minimum time, maximum time, and average time
total_time <- sum(fit_times)
median_time <- median(fit_times)
min_time <- min(fit_times)
max_time <- max(fit_times)
avg_time <- mean(fit_times)

# Print the results to the console
cat("Total time: ", total_time, "\n")
cat("Median time: ", median_time, "\n")
cat("Minimum time: ", min_time, "\n")
cat("Maximum time: ", max_time, "\n")
cat("Average time: ", avg_time, "\n")

