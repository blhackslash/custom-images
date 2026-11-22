#!/usr/bin/env bash
# Usage: smoke-test.sh <image>
# Converts a generated test image and clip end to end and checks the log.
set -euo pipefail
image="$1"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
mkdir -p "$work/in" "$work/out"
docker run --rm -v "$work/in:/data/input" "$image" ffmpeg -loglevel error -f lavfi -i testsrc=size=320x240 -frames:v 1 "/data/input/test image.jpg"
docker run --rm -v "$work/in:/data/input" "$image" ffmpeg -loglevel error -f lavfi -i testsrc=size=320x240:rate=25 -t 2 -c:v mpeg4 "/data/input/test clip.mov"
docker run --rm -e HW_ACCEL=false -v "$work/in:/data/input:ro" -v "$work/out:/data/output" "$image" | tee "$work/run.log"
grep -q "Pipeline Finished Successfully" "$work/run.log"
! grep -E "\[(FAIL|ERROR)\]|: (FAIL|ERROR)" "$work/run.log"
