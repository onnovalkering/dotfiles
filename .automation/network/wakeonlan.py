from __future__ import annotations

from binascii import unhexlify

from loguru import logger
from scapy import all as scapy


def wake_on_lan(target: str, configuration):
    packet = create_magic_packet(target)
    destination = scapy.IP(dst="255.255.255.255") / scapy.UDP(dport=9)

    scapy.send(destination / packet, verbose=False)


def create_magic_packet(hw_addr) -> scapy.Raw:
    hw_addr = "".join([str(unhexlify(h)) for h in hw_addr.split(":")])
    packet = scapy.Raw(load=chr(0xFF) * 6 + hw_addr * 16)

    return packet
