"""Minimal pandas stub for local/offline usage."""

import csv

class DataFrame:
    def __init__(self, rows, columns):
        self._rows = rows
        self.columns = list(columns)

    @property
    def shape(self):
        return (len(self._rows), len(self.columns))

    def __getitem__(self, key):
        if isinstance(key, list):
            filtered_rows = [
                {col: row[col] for col in key}
                for row in self._rows
            ]
            return DataFrame(filtered_rows, key)
        if isinstance(key, str):
            return [row[key] for row in self._rows]
        raise KeyError(key)

    def to_list(self):
        return [[row[col] for col in self.columns] for row in self._rows]


def read_csv(path):
    with open(path, newline="") as handle:
        reader = csv.DictReader(handle)
        rows = []
        for row in reader:
            parsed = {k: float(v) if v.replace('.', '', 1).isdigit() else v for k, v in row.items()}
            rows.append(parsed)
        return DataFrame(rows, reader.fieldnames)
