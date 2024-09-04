#!/bin/bash

# Detect system architecture
ARCH=$(uname -m)
if [ "$ARCH" == "arm64" ]; then
  export DOCKER_PLATFORM="linux/amd64"
else
  export DOCKER_PLATFORM=""
fi

# Run the molecule tests
molecule test