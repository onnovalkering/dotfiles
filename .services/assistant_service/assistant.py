import os
import pwd
import sys

from flask import Flask, request
from paramiko import SSHClient
from wakeonlan import send_magic_packet
from time import sleep
from threading import Thread

app = Flask(__name__)


@app.route("/backup", methods=["POST"])
def backup():
    def task(address, hostname):
        send_magic_packet(address)
        sleep(30)
        remote_command(hostname, "~/.backup/run.sh")

    address = request.form["address"]
    hostname = request.form["hostname"]

    thread = Thread(target=task, args=(address, hostname))
    thread.start()

    return app.make_response(("", 202))


@app.route("/turn-on", methods=["POST"])
def turn_on():
    address = request.form["address"]
    send_magic_packet(address)

    return app.make_response(("", 202))


@app.route("/turn-off", methods=["POST"])
def turn_off():
    hostname = request.form["hostname"]

    remote_command(hostname, "sudo shutdown -h 0")

    return app.make_response(("", 202))


def remote_command(hostname, command):
    username = pwd.getpwuid(os.getuid())[0]

    client = SSHClient()
    client.load_system_host_keys()
    client.connect(hostname, username=username)
    client.exec_command(command)


if __name__ == "__main__":
    if sys.platform == "linux":
        from systemd import daemon

        daemon.notify("READY=1")

    app.run(host="0.0.0.0")
