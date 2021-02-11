#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

: ${TARGET_HOST:=pi@raspberrypi}
: ${TARGET_PATH:=/home/pi/raspberry_build}
: ${TARGET_ARCH:=arm-unknown-linux-musleabihf}
: ${SOURCE_PATH:=./target/${TARGET_ARCH}/release/raspberry_build}

cargo build --release --target=${TARGET_ARCH}
scp ${SOURCE_PATH} ${TARGET_HOST}:${TARGET_PATH}
ssh -t ${TARGET_HOST} ${TARGET_PATH}