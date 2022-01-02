from http.server import HTTPServer, BaseHTTPRequestHandler
import time
import RPi.GPIO as GPIO
import json

# Pin to use as the input from the sensor
SIGNAL_PIN = 2

GPIO.setmode(GPIO.BCM)
GPIO.setup(SIGNAL_PIN, GPIO.IN)

debugMode = False

class Server(BaseHTTPRequestHandler):
    def __init__(self, request, client_address, server):
        BaseHTTPRequestHandler.__init__(self, request, client_address, server)
        self.debugMode = False

    # sets the http headers to a successful request
    def setSuccessHeaders(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()

    # sets the http headers to a unsuccessful request
    def setFailureHeaders(self):
        self.send_response(400)
        self.send_header('Content-type', 'application/json')
        self.end_headers()

    # loads the index.html page
    def do_GET(self):
        global debugMode

        self.setSuccessHeaders()

        if self.path == '/debug':
            debugMode = not debugMode
            content = json.dumps({'message': 'Toggled debug mode', 'debugMode': debugMode})
        else:
            hasSignal = not GPIO.input(SIGNAL_PIN)

            if debugMode:
                content = json.dumps({ 'state': True, 'debug': True, 'actualState': hasSignal })
            else:
                content = json.dumps({ 'state': hasSignal })


        self.wfile.write(content.encode("utf8"))

    # sets the success headers for all requests, if there is an error failure headers will be set manually
    def do_HEAD(self):
        self.setSuccessHeaders()


if __name__ == '__main__':
    # Serve on port 8000
    PORT_NUMBER = 8080

    # Create a new HTTPServer with the above port number and the custom Server written above
    httpd = HTTPServer(('', PORT_NUMBER), Server)

    # Log the server start time to the console
    print(time.asctime(), 'Server Starts - %s:%s' % ('', PORT_NUMBER))
    
    # wait for keyboard interrupt while running http server, if it occurs, break out of loop and close the server
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    
    # clean up after yourself! (httpd needs to be closed to prevent memory leaks)
    httpd.server_close()

    # log the server stop time
    print(time.asctime(), 'Server Stops - %s:%s' % ('', PORT_NUMBER))

    GPIO.cleanup()