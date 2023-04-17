from sklearn.tree import DecisionTreeClassifier, plot_tree
from sklearn.metrics import accuracy_score, confusion_matrix
import pandas as pd
import matplotlib.pyplot as plt

# Load your data into a pandas dataframe
data = pd.read_csv('C:/Users/hyrum/Documents/github/model-benchmarking/data/classification_data.csv')

# Split the data into feature matrix (X) and target vector (y)
X = data[['x1', 'x2', 'x3']]
y = data['y']

# Create decision tree classifier object
clf = DecisionTreeClassifier(max_depth=2)

# Fit the model to the entire dataset
clf.fit(X, y)

# Predict the class labels of the test set
y_pred = clf.predict(X)

# Compute the accuracy score of the model
accuracy = accuracy_score(y, y_pred)

# Output the accuracy score
print("Accuracy:", accuracy)

# Output a plot of the decision tree
plt.figure(figsize=(20, 10))
plot_tree(clf, filled=True)
plt.show()

# Output a confusion matrix
cm = confusion_matrix(y, y_pred)
print("Confusion matrix:")
print(cm)
