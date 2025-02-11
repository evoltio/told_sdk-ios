#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: <pod|spm>"
    exit 1
fi

PARAM="$1"
if [ "$PARAM" = "pod" ]; then
    echo "Generated Pod files"
    CONFIG="apollo-codegen-config-cocoapods.json"
elif [ "$PARAM" = "spm" ]; then
    echo "Generated SPM files"
    CONFIG="apollo-codegen-config-spm.json"
else
    echo "Invalid input. Please enter 'spm|pod'"
    exit 1
fi

GENERATED_DIR="Sources/Remote/Generated"
CUSTOM_SCALAR_FILE="JSON.swift"

find "$GENERATED_DIR" -type f ! -name "$CUSTOM_SCALAR_FILE" -type f -exec rm -f {} +

./apollo-ios-cli generate --path "$CONFIG"
