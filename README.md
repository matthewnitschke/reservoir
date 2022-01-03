# Reservoir

A server and plugin setup for a [decent espresso machine](https://github.com/decentespresso/de1app) that monitors wastewater level with a proximity sensor

The server can run on a raspberry pi and my setup uses a cheap xkc-y25-npn water sensor

The tcl plugin will notify you on boot if your water reservoir is full or not

# Setup - Software

### Server

1. Clone the repo into a raspberry pi and run `cd server && sudo ./install.sh`, this script will automatically install and start the service via `systemctl`
2. Attach a water level sensor to GPIO pin `2`

### Plugin

1. Setup a sftp server on your tablet, set port to `2222` and default directory to `de1plus`
2. Run `cd plugin && install.sh yourUser@yourTabletIPAddr`
3. Reboot the de1plus app
4. Go to settings -> plugins, and enable the 'Reservoir' plugin

# Setup - Hardware

For my setup, I am using xkc-y25-npn non contact liquid sensors, and a basic raspberry pi (any would do, I think I'm using a B+ model 3)

![image](https://user-images.githubusercontent.com/6363089/147900841-b5385e37-301a-4943-bbb9-99395d970841.png)

Connection is quite easy:
- Brown wire goes to the 5v connection on the pi
- Yellow wire goes to GPIO pin 2 on the pi
- Blue wire goes to GND on the pi
- Black wire can be ignored


# Development

The server runs against port `8080`, water level calls can be run directly against this: `http://IP_ADDR_OF_PI:8080`

There is also a "debug" mode which will force the sensor to be `true`, you can toggle this mode by going to: `http://IP_ADDR_OF_PI:8080/debug`

