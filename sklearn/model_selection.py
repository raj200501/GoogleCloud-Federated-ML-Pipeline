"""Minimal train_test_split implementation for local/offline usage."""

from typing import Tuple


def _slice_data(data, indices):
    if hasattr(data, "_rows"):
        rows = [data._rows[i] for i in indices]
        return data.__class__(rows, data.columns)
    return [data[i] for i in indices]


def train_test_split(X, y, test_size=0.2, random_state=None) -> Tuple:
    total = len(y)
    split = int(total * (1 - test_size))
    indices = list(range(total))
    train_idx = indices[:split]
    test_idx = indices[split:]
    X_train = _slice_data(X, train_idx)
    X_test = _slice_data(X, test_idx)
    y_train = _slice_data(y, train_idx)
    y_test = _slice_data(y, test_idx)
    return X_train, X_test, y_train, y_test
