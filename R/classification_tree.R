# load the required packages
library(rpart)
library(rpart.plot)
library(caret)

# load the example dataset "data" which has 4 predictors and 3 classes
data <- read.csv("data/classification_data.csv")[,c(2:5)]

# convert the response variable "Species" to a factor
data$y <- as.factor(data$y)

# set the random seed for reproducibility
set.seed(123)

# fit a classification tree model using the "rpart" function
tree_model <- rpart(y ~ ., data = data, method = "class")

# Table of correct/incorrect predictions on training data
preds = predict(tree_model, data = data, type = "class")
table(data$y, preds)

# Model accuracy
sum(diag(table(data$y, preds)))/sum(table(data$y, preds))


# plot the tree using the "rpart.plot" function
rpart.plot(tree_model, type = 4, extra = 102,
           under = TRUE, cex = 0.8, box.palette = "Blues")

# Initialize an empty vector to store the fit times
fit_times <- numeric()

# Loop over 500 iterations and fit the decision tree model
for (i in 1:500) {
  # Record the start time
  t0 <- Sys.time()

  # Fit the decision tree model
  model <- rpart(y ~ ., data = data, method = "class")

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

boxplot(fit_times)
