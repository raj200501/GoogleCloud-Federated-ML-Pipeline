"""Minimal TensorFlow stub for local/offline usage.

This module provides a tiny subset of the TensorFlow Keras API used by this repo.
It enables running training and loading a saved model without external deps.
"""

import json
from pathlib import Path

class _Dense:
    def __init__(self, units, activation=None, input_shape=None):
        self.units = units
        self.activation = activation
        self.input_shape = input_shape

class _Sequential:
    def __init__(self, layers=None):
        self.layers = layers or []
        self._compiled = False
        self._history = {}

    def compile(self, optimizer=None, loss=None, metrics=None):
        self._compiled = True
        self._compile_config = {
            "optimizer": optimizer,
            "loss": loss,
            "metrics": metrics or [],
        }

    def fit(self, X_train, y_train, epochs=1, validation_data=None):
        self._history = {
            "epochs": epochs,
            "samples": len(y_train),
        }
        return self._history

    def save(self, path):
        Path(path).parent.mkdir(parents=True, exist_ok=True)
        payload = {
            "layers": [layer.__dict__ for layer in self.layers],
            "compiled": getattr(self, "_compiled", False),
            "history": self._history,
        }
        Path(path).write_text(json.dumps(payload, indent=2))

class _Models:
    @staticmethod
    def load_model(path):
        model = _Sequential()
        if Path(path).exists():
            model._loaded_payload = json.loads(Path(path).read_text())
        return model

class _Layers:
    Dense = _Dense

class _Keras:
    Sequential = _Sequential
    layers = _Layers()
    models = _Models()

keras = _Keras()
