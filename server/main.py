from threading import Thread
import socket

class Audiosocket:
    def __init__(self, address):
        self.address = address
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.bind(self.address)
        self.socket.listen(5)
        print("Listening on {}".format(self.address))  # Use str.format()

    def listen(self):
        conn, addr = self.socket.accept()
        print("Connection established with {}".format(addr))  # Use str.format()
        return conn

class Connection:
    def __init__(self, conn, peer_addr):
        self.conn = conn
        self.peer_addr = peer_addr
        self.connected = True

    def read(self):
        return self.conn.recv(1024)

    def write(self, data):
        self.conn.sendall(data)

    def close(self):
        self.conn.close()

# Create the Audiosocket instance
audiosocket = Audiosocket(("127.0.0.1", 5001))

def handle_connection(conn):
    while conn.connected:
        data = conn.read()
        if data:
            conn.write(data)  # Echo back the data
        else:
            break

    print("Connection with {} is over".format(conn.peer_addr))  # Use str.format()
    conn.close()

while True:
    conn = audiosocket.listen()
    connection = Connection(conn, conn.getpeername())
    connection_thread = Thread(target=handle_connection, args=(connection,))
    connection_thread.start()
