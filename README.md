# Reservoir

A server and plugin setup for a [decent espresso machine](https://github.com/decentespresso/de1app) that monitors wastewater level with a proximity sensor

# Installation

## Server

1. Clone the repo into a raspberry pi and run `cd server && sudo ./install.sh`, this script will automatically install and start the service via `systemctl`
2. Attach a water level sensor to GPIO pin `2`

## Plugin

1. Setup a sftp server on your tablet, set port to `2222` and default directory to `de1plus`
2. Run `cd plugin && install.sh yourUser@yourTabletIPAddr`
3. Reboot the de1plus app