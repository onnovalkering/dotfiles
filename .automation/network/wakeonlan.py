from __future__ import annotations

from binascii import unhexlify
from network.devices import NetworkDevice
from loguru import logger
from scapy import all as scapy


def wake_on_lan(target: str, configuration):
    """ """
    hw_addr = lookup_hw_addr(target, configuration.devices)
    if hw_addr is None:
        logger.error(f"Couldn't find hardware address for target '{target}'.")
        return

    packet = create_magic_packet(hw_addr)
    broadcast = (
        scapy.Ether(dst="ff:ff:ff:ff:ff:ff")
        / scapy.IP(dst="255.255.255.255")
        / scapy.UDP(dport=9)
    )

    scapy.sendp(broadcast / packet, verbose=False)


def lookup_hw_addr(target: str, devices: list[NetworkDevice]) -> str:
    """ """
    def match(device: NetworkDevice):
        return (
            target == device.ip_addr
            or target == device.hostname
            or target == device.hostname.removesuffix(".local")
        )

    results = list(filter(match, devices))
    return None if len(results) == 0 else results[0].hw_addr


def create_magic_packet(hw_addr) -> scapy.Raw:
    """ """
    hw_addr = unhexlify(hw_addr.replace(":", ""))
    packet = scapy.Raw(load=b"\xff" * 6 + hw_addr * 16)

    return packet
