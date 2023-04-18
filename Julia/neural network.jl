using Flux
using Flux: @epochs, mse

# load the example dataset "data" which has 4 predictors and 3 classes
using CSV, DataFrames, Random
data = CSV.read("C:/Users/Hyrum Hansen/Documents/github/model-benchmarking/data/regression_data.csv", DataFrame)
data = data[shuffle(1:end), :]
n_obs = size(data, 1)

# Prepare the dataset
x_train = data[1:1500, 2:5]
y_train = data[1:1500, 1]
x_test = data[1501:n_obs, 2:5]
y_test = data[1501:n_obs, 1]

# Declare the model
model = Chain(
    Dense(4, 128, relu),
    Dense(128, 64, relu),
    Dense(64, 32, relu),
    Dense(32, 1)
)

using Flux: mse, Optimise
using Statistics: mean

loss(x, y) = mse(model(x), y)
opt = ADAM(0.001)
n_epochs = 100

for i in 1:n_epochs
    Flux.train!(loss, [(x_train', y_train)], opt)
end

# Calculate the mean squared error on the test set
test_loss = mean([MSE(model(x_test[:,i]), y_test[i]) for i in 1:size(x_test, 2)])


