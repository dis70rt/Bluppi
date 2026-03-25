#!/bin/bash

PROTO_DIR="./lib/protobufs"
OUT_DIR="./lib/generated"

# GOOGLE_PROTO_DIR="$HOME/bin/protobuf/src" 
GOOGLE_PROTO_DIR="/usr/include"

mkdir -p "$OUT_DIR"

echo "Generating Dart code from .proto files..."
protoc --dart_out=grpc:"$OUT_DIR" \
    -I"$PROTO_DIR" \
    -I"$GOOGLE_PROTO_DIR" \
    "$PROTO_DIR"/*.proto \
    "google/protobuf/timestamp.proto"

echo "Protobuf code generation complete."
echo "Generated files are in $OUT_DIR"