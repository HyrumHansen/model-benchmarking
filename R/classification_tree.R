# load the required packages
library(rpart)
library(rpart.plot)
library(caret)

# load the example dataset "data" which has 4 predictors and 3 classes
data <- read.csv("data/classification_data.csv")

# convert the response variable "Species" to a factor
data$y <- as.factor(data$y)

# set the random seed for reproducibility
set.seed(123)

# split the data into training and testing sets
trainIndex <- createDataPartition(data$y, p = 0.8, list = FALSE)
trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]

# fit a classification tree model using the "rpart" function
tree_model <- rpart(y ~ x1+x2+x3, data = trainData, method = "class")


PredictCART_train = predict(tree_model, data = trainData, type = "class")
table(trainData$y, PredictCART_train)


# plot the tree using the "rpart.plot" function
rpart.plot(tree_model, type = 4, extra = 102, under = TRUE, cex = 0.8, box.palette = "Blues")
