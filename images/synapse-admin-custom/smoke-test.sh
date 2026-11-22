#!/usr/bin/env bash
# Usage: smoke-test.sh <image>
# Starts the container and checks the UI answers on 8081.
set -euo pipefail
cid="$(docker run -d -p 18081:8081 "$1")"
trap 'docker rm -f "$cid" >/dev/null' EXIT
for _ in $(seq 1 20); do
  if curl -fsS -o /dev/null http://127.0.0.1:18081/; then echo "synapse-admin answers on 8081"; exit 0; fi
  sleep 1
done
docker logs "$cid"; exit 1
