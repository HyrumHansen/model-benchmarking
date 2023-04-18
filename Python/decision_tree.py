from sklearn.tree import DecisionTreeClassifier, plot_tree
import pandas as pd
import time
import numpy as np

# Load your data into a pandas dataframe
data = pd.read_csv('C:/Users/Hyrum Hansen/Documents/github/model-benchmarking/data/classification_data.csv')

# Split the data into feature matrix (X) and target vector (y)
X = data[['x1', 'x2', 'x3']]
y = data['y']

n = 500 # Number of times to build the decision tree
train_times = [0] * n # List to store training times for each iteration
for i in range(n):

    start_time = time.time() # Start timing
    clf = DecisionTreeClassifier()
    clf.fit(X, y)
    train_time = time.time() - start_time # Calculate training time

    train_times[i] = train_time

# Calculate statistics
total_time = sum(train_times)
median_time = np.median(train_times)
mean_time = np.mean(train_times)
min_time = min(train_times)
max_time = max(train_times)

# Print results
print(f"Total time: {total_time:.4f} seconds")
print(f"Median time: {median_time:.4f} seconds")
print(f"Mean time: {mean_time:.4f} seconds")
print(f"Minimum time: {min_time:.4f} seconds")
print(f"Maximum time: {max_time:.4f} seconds")



