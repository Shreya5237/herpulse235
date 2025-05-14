import numpy as np
from sklearn.linear_model import LinearRegression

# Sample normalized data (replace with your actual data)
X = np.array([21, 28, 35], dtype=np.float32).reshape(-1, 1)  # Input
y = np.array([21, 28, 35], dtype=np.float32)  # Output

# Normalize data (using the min and max of the dataset)
X_min, X_max = X.min(), X.max()
y_min, y_max = y.min(), y.max()

X = (X - X_min) / (X_max - X_min)  # Normalize X between 0 and 1
y = (y - y_min) / (y_max - y_min)  # Normalize y between 0 and 1

# Train a linear regression model
model = LinearRegression()
model.fit(X, y)

# Normalize input data for prediction (using X's min and max from training)
input_data = np.array([[28]], dtype=np.float32)
input_data_normalized = (input_data - X_min) / (X_max - X_min)  # Normalize input

# Make prediction
prediction = model.predict(input_data_normalized)

# Reverse normalization to get the output back to the original scale
predicted_value = prediction[0] * (y_max - y_min) + y_min  # Reverse normalization for y

print(f"Next cycle prediction: {predicted_value:.1f} days")