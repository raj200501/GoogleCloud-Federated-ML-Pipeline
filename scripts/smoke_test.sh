#!/bin/bash
set -euo pipefail

export LOCAL_MODE=1

./scripts/federated_training.sh

python3 - <<'PY'
import tensorflow as tf
model = tf.keras.models.load_model('./model_output/model.h5')
print("Loaded model:", type(model))
PY

python3 - <<'PY'
import json
with open('./model_output/metrics.json') as handle:
    metrics = json.load(handle)
print("Metrics keys:", list(metrics.keys()))
PY

python3 scripts/serve_local.py &
SERVER_PID=$!
sleep 1
python3 - <<'PY'
import json
import urllib.request

with urllib.request.urlopen("http://127.0.0.1:8080/health") as response:
    payload = json.loads(response.read().decode("utf-8"))
print("Health:", payload["status"])

req = urllib.request.Request(
    "http://127.0.0.1:8080/predict",
    data=json.dumps({"features": [0.1, 0.2]}).encode("utf-8"),
    headers={"Content-Type": "application/json"},
)
with urllib.request.urlopen(req) as response:
    payload = json.loads(response.read().decode("utf-8"))
print("Score:", payload["score"])
PY
kill "${SERVER_PID}"

echo "Smoke test completed successfully."
