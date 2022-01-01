#!/bin/bash

SCRIPT_DIR=$(dirname "$0")

cp reservoir.service /etc/systemd/system

EXEC_PATH="$(pwd)/start.sh"

sed -i '' "s+PATH_TO_EXEC+$EXEC_PATH+g" /etc/systemd/system/reservoir.service