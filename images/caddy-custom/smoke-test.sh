#!/usr/bin/env bash
# Usage: smoke-test.sh <image>
set -euo pipefail
docker run --rm "$1" caddy version
