# Usage:
# ./install "yourUser@yourIp"

# user+ip: someUser@192.168.1.x
HOST=$1

PORT="2222"

sftp "sftp://$HOST:$PORT" <<END
mkdir plugins/reservoir
cd plugins/reservoir

put plugin.tcl plugin.tcl
END