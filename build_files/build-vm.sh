#!/usr/bin/env bash
set -euo pipefail

sudo podman build --pull=newer -t localhost/vorteq-nas-os:test -f system_files/Containerfile .

mkdir -p output
sudo podman run --rm --privileged --pull=newer \
  --security-opt label=type:unconfined_t \
  -v ./system_files/config.toml:/config.toml:ro \
  -v ./output:/output \
  -v /var/lib/containers/storage:/var/lib/containers/storage \
  quay.io/centos-bootc/bootc-image-builder:latest \
  --type vmdk --rootfs ext4 \
  localhost/vorteq-nas-os:test