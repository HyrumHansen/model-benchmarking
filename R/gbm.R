library(xgboost)

# load the example dataset "data" which has 4 predictors and 3 classes
data <- read.csv("data/classification_data.csv")[,c(2:5)]

#Split the data into features and target
features <- data[,c("x1", "x2", "x3")]
target <- data$y

# Convert the data to a DMatrix object
dtrain <- xgb.DMatrix(data = as.matrix(features), label = target)

# Set the hyperparameters for the gradient boosting model
params <- list(objective = "reg:squarederror",
               booster = "gbtree",
               eta = 0.1,
               max_depth = 3,
               subsample = 0.8,
               colsample_bytree = 0.8)

# Train the gradient boosting model with 100 iterations
model <- xgb.train(params = params, data = dtrain, nrounds = 100)

# Initialize an empty vector to store the fit times
fit_times <- numeric()

# Loop over 500 iterations and fit the decision tree model
for (i in 1:500) {
  # Record the start time
  t0 <- Sys.time()

  # Fit the decision tree model
  model <- xgb.train(params = params, data = dtrain, nrounds = 100)

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

