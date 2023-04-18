from keras.models import Sequential
from keras.layers import Dense
import pandas as pd
import numpy as np
import time

# load the example dataset "data" which has 4 predictors and 3 classes
np.random.seed(1234)
data = pd.read_csv("C:/Users/Hyrum Hansen/Documents/github/model-benchmarking/data/regression_data.csv")
data = data.sample(frac=1)
n_obs = len(data)

# Prepare the dataset
x_train = data.iloc[:1500, 1:5].values
y_train = data.iloc[:1500, 0].values.reshape(-1,1)
x_test = data.iloc[1501:n_obs, 1:5].values
y_test = data.iloc[1501:n_obs, 0].values.reshape(-1,1)

# Define the neural network architecture
model = Sequential()
model.add(Dense(units=128, activation='relu', input_shape=(4,)))
model.add(Dense(units=64, activation='relu'))
model.add(Dense(units=32, activation='relu'))
model.add(Dense(units=1))

# Compile the model
model.compile(loss='mse', optimizer='adam', metrics=['mean_squared_error'])

model.summary()

# Train the model
history = model.fit(x_train, y_train, epochs=100)

# Initialize an empty vector to store the fit times
fit_times = []

# Loop over 50 iterations and fit the decision tree model
for i in range(50):
  # Record the start time
  t0 = time.time()

  # Define the neural network architecture
  model = Sequential()
  model.add(Dense(units=128, activation='relu', input_shape=(4,)))
  model.add(Dense(units=64, activation='relu'))
  model.add(Dense(units=32, activation='relu'))
  model.add(Dense(units=1))

  # Compile the model
  model.compile(loss='mse', optimizer='adam', metrics=['mean_squared_error'])

  # Train the model
  history = model.fit(x_train, y_train, epochs=8, verbose=0)

  # Record the end time
  t1 = time.time()

  # Calculate the fit time and append it to the fit_times vector
  fit_time = t1 - t0
  fit_times.append(fit_time)

# Calculate the total time, median time, minimum time, maximum time, and average time
total_time = sum(fit_times)
median_time = np.median(fit_times)
min_time = min(fit_times)
max_time = max(fit_times)
avg_time = np.mean(fit_times)

# Print the results to the console
print("Total time:", total_time)
print("Median time:", median_time)
print(f"Mean time: {avg_time:.4f} seconds")
print(f"Minimum time: {min_time:.4f} seconds")
print(f"Maximum time: {max_time:.4f} seconds")