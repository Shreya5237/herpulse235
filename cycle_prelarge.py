import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, mean_absolute_error

# Generate a large synthetic dataset
np.random.seed(42)
X = np.random.randint(20, 36, size=1000).reshape(-1, 1)  # Cycle durations (in days)
noise = np.random.normal(0, 2, size=1000)  # Random noise
y = X.flatten() + noise  # Next cycle duration with some variation

# Normalize data (optional, based on your needs)
X_min, X_max = X.min(), X.max()
y_min, y_max = y.min(), y.max()
X_normalized = (X - X_min) / (X_max - X_min)
y_normalized = (y - y_min) / (y_max - y_min)

# Split the dataset into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X_normalized, y_normalized, test_size=0.2, random_state=42)

# Train a Linear Regression model
model = LinearRegression()
model.fit(X_train, y_train)

# Evaluate the model
y_pred = model.predict(X_test)
mse = mean_squared_error(y_test, y_pred)
mae = mean_absolute_error(y_test, y_pred)

print(f"Model Evaluation:")
print(f"Mean Squared Error: {mse:.4f}")
print(f"Mean Absolute Error: {mae:.4f}")

# Predict the next cycle for a new input
input_data = np.array([[28]])  # Example input in days
input_data_normalized = (input_data - X_min) / (X_max - X_min)  # Normalize input
predicted_value_normalized = model.predict(input_data_normalized)

# Reverse normalization to get the output in original scale
predicted_value = predicted_value_normalized[0] * (y_max - y_min) + y_min
print(f"Next cycle prediction: {predicted_value:.1f} days")
