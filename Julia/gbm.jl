using EvoTrees, CSV, DataFrames, CategoricalArrays, Statistics
using EvoTrees: importance

# Load data
data = DataFrame(CSV.read("C:/Users/Hyrum Hansen/Documents/github/model-benchmarking/data/classification_data.csv", DataFrame))
data[!, :y] = data[!, :y]

y_train, x_train = data[!, :y], Matrix(select(data, Not([:Column1, :y])))

params = EvoTreeRegressor(
    loss=:linear, metric=:mse,
    nrounds=100, eta=0.1,
    max_depth = 3, min_weight = 1.0,
    rowsample=0.8, colsample=0.8)

# Initialize an empty vector to store the fit times
fit_times = Float64[]

# Loop over n iterations and fit the decision tree model
for i in 1:500

    t0 = time()
    model = fit_evotree(params; x_train, y_train)
    t1 = time()

    fit_time = t1 - t0
    push!(fit_times, fit_time)
    
end

# Calculate the total time, median time, minimum time, maximum time, and average time
total_time = sum(fit_times)
median_time = median(fit_times)
min_time = minimum(fit_times)
max_time = maximum(fit_times)
avg_time = mean(fit_times)

# Print the results to the console
println("Total time: ", total_time)
println("Median time: ", median_time)
println("Minimum time: ", min_time)
println("Maximum time: ", max_time)
println("Average time: ", avg_time)
