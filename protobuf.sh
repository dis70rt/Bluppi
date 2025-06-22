export PATH="$PATH":"$HOME/.pub-cache/bin"

mkdir -p lib/generated

PROTOC_INCLUDE_PATH=$(dirname $(dirname $(which protoc)))/include
if [ ! -d "$PROTOC_INCLUDE_PATH/google/protobuf" ]; then
  PROTOC_INCLUDE_PATH="/usr/include"
fi

echo "Using protoc include path: $PROTOC_INCLUDE_PATH"
echo "Generating Google protobuf types..."

protoc --dart_out=grpc:lib/generated \
  -I"$PROTOC_INCLUDE_PATH" \
  -Ilib \
  "$PROTOC_INCLUDE_PATH/google/protobuf/timestamp.proto" \
  "$PROTOC_INCLUDE_PATH/google/protobuf/empty.proto"

echo "Generating custom protobuf types..."

protoc --dart_out=grpc:lib/generated \
  -Ilib \
  -I"$PROTOC_INCLUDE_PATH" \
  lib/protobuf/common.proto \
  lib/protobuf/user.proto \
  lib/protobuf/track.proto \
  lib/protobuf/playback.proto \
  lib/protobuf/queue.proto \
  lib/protobuf/room.proto \
  lib/protobuf/events.proto \
  lib/protobuf/streaming.proto

echo "Proto files generated successfully!"