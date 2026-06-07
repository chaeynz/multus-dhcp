#!/bin/bash

ALPINE_TAG=$(grep '^FROM alpine:' Dockerfile | head -1 | cut -d':' -f2 | cut -d' ' -f1 | cut -d'@' -f1)

source cni_plugins_version.env

IMAGE_NAME=ghcr.io/chaeynz/multus-dhcp

TAG=${CNI_PLUGINS_VER}-${ALPINE_TAG}

DOCKER_TAGS=(
    "$TAG"
    latest
)

for tag in "${DOCKER_TAGS[@]}"; do
    DOCKER_BUILD_ARGS+=(-t "$IMAGE_NAME":"$tag")
done

if [ "${1}" == "--push" ]; then
  DOCKER_BUILD_ARGS+=(
    --output=type=image
    --push
  )
else
  DOCKER_BUILD_ARGS+=(
    --output=type=docker
  )
fi

docker build --build-arg CNI_PLUGINS_VER=${CNI_PLUGINS_VER} "${DOCKER_BUILD_ARGS[@]}" .
