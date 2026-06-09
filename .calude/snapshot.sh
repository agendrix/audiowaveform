#!/bin/bash
# snapshot.sh — runs once during /warm to build the snapshot baseline.
# Output of this script is what gets baked into the persisted snapshot.
# Edit this file, then commit and push to keep changes.
# See also: .calude/boot.sh (runs after every snapshot restore).
set -euo pipefail

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
  build-essential cmake \
  libmad0-dev libid3tag0-dev libsndfile1-dev libgd-dev \
  libboost-filesystem-dev libboost-program-options-dev libboost-regex-dev

cd "$HOME/workspace"

if [ ! -e googletest ]; then
  wget -q https://github.com/google/googletest/archive/release-1.12.1.tar.gz
  tar xzf release-1.12.1.tar.gz
  ln -sf googletest-release-1.12.1 googletest
fi

mkdir -p build
cd build
cmake .. -D CMAKE_BUILD_TYPE=Release
cmake --build . -j "$(nproc)"