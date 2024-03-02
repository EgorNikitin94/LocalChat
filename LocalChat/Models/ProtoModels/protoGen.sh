#!/bin/sh

#  protoGen.sh
#  LocalChat
#
#  Created by Егор Никитин on 3/3/24.
#  

#!/bin/bash
SRC_DIR="/Users/egornikitin/MyProjects/LocalChatProto"
DST_DIR="/Users/egornikitin/MyProjects/LocalChat/LocalChat/LocalChat/Models/ProtoModels"

protoc -I=$SRC_DIR --swift_out=$DST_DIR $SRC_DIR/sys.proto
protoc -I=$SRC_DIR --swift_out=$DST_DIR $SRC_DIR/local_chat.proto
protoc -I=$SRC_DIR --swift_out=$DST_DIR $SRC_DIR/auth.proto
protoc -I=$SRC_DIR --swift_out=$DST_DIR $SRC_DIR/users.proto
protoc -I=$SRC_DIR --swift_out=$DST_DIR $SRC_DIR/dialogs.proto
protoc -I=$SRC_DIR --swift_out=$DST_DIR $SRC_DIR/messages.proto
