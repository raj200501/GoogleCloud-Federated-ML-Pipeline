#!/usr/bin/env python3
"""Simple local inference server for the trained model artifacts."""
import json
import os
from http.server import BaseHTTPRequestHandler, HTTPServer

MODEL_PATH = os.environ.get("MODEL_PATH", "./model_output/model.h5")
METRICS_PATH = os.environ.get("METRICS_PATH", "./model_output/metrics.json")
HOST = os.environ.get("HOST", "0.0.0.0")
PORT = int(os.environ.get("PORT", "8080"))


def _load_metrics():
    if os.path.exists(METRICS_PATH):
        with open(METRICS_PATH) as handle:
            return json.load(handle)
    return {}


class Handler(BaseHTTPRequestHandler):
    def _send(self, status, payload):
        body = json.dumps(payload).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        if self.path == "/health":
            self._send(200, {"status": "ok", "model_path": MODEL_PATH})
            return
        if self.path == "/metrics":
            self._send(200, _load_metrics())
            return
        self._send(404, {"error": "not found"})

    def do_POST(self):
        if self.path != "/predict":
            self._send(404, {"error": "not found"})
            return
        content_length = int(self.headers.get("Content-Length", "0"))
        body = self.rfile.read(content_length) if content_length else b"{}"
        try:
            payload = json.loads(body.decode("utf-8"))
        except json.JSONDecodeError:
            payload = {}
        features = payload.get("features", [])
        # Placeholder inference: return a deterministic score based on feature sum.
        score = round(sum(features) / (len(features) or 1), 4) if features else 0.0
        self._send(200, {"score": score, "model_path": MODEL_PATH})


if __name__ == "__main__":
    server = HTTPServer((HOST, PORT), Handler)
    print(f"Local server running on http://{HOST}:{PORT}")
    server.serve_forever()
