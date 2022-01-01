#!/bin/bash

SCRIPT_DIR=$(dirname "$0")

pushd

cd $SCRIPT_DIR

cp reservoir.service /etc/systemd/system

EXEC_PATH="$(pwd)/start.sh"

sed -i "s/<path to exec>/$EXEC_PATH/g" /etc/systemd/system/reservoir.service

popd