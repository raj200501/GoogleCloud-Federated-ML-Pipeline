import argparse
import tensorflow as tf
import pandas as pd
from tensorflow import keras
from sklearn.model_selection import train_test_split

# Parse command line arguments
parser = argparse.ArgumentParser()
parser.add_argument('--data_path', required=True, help='Path to training data')
parser.add_argument('--output_path', required=True, help='Path to save the model')
args = parser.parse_args()

# Load and preprocess data
data = pd.read_csv(args.data_path)
X = data[['feature1', 'feature2']]
y = data['label']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Define the model
model = keras.Sequential([
    keras.layers.Dense(64, activation='relu', input_shape=(X_train.shape[1],)),
    keras.layers.Dense(64, activation='relu'),
    keras.layers.Dense(1, activation='sigmoid')
])

model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

# Train the model
model.fit(X_train, y_train, epochs=10, validation_data=(X_test, y_test))

# Save the model
model.save(args.output_path + '/model.h5')
