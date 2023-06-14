#!/usr/bin/env bash

# Create ISO 8601 timestamp
TS=$(date +'%Y-%m-%dT%H:%M:%SZ')

echo "Output from ${0}, from user account $USER, requesting current timestamp = $TS"
