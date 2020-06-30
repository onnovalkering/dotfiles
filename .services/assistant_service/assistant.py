import os
import pwd
import sys

from flask import Flask, request
from wakeonlan import send_magic_packet
from paramiko import SSHClient

app = Flask(__name__)

@app.route("/turn-on", methods=["POST"])
def turn_on():
    address = request.form["address"]
    send_magic_packet(address)

    return app.make_response(("", 202))


@app.route("/turn-off", methods=["POST"])
def turn_off():
    address = request.form["address"]
    username = pwd.getpwuid(os.getuid())[0]

    client = SSHClient()
    client.load_system_host_keys()
    client.connect(address, username=username)
    client.exec_command('sudo shutdown -h 0')

    return app.make_response(("", 202))


if __name__ == "__main__":
    if sys.platform == "linux":
        from systemd import daemon
        daemon.notify("READY=1")

    app.run(host="0.0.0.0")
