from __future__ import annotations

from socket import gethostbyaddr

from loguru import logger
from scapy import all as scapy
from yaml import FullLoader, add_constructor
from yaml.nodes import MappingNode


class NetworkDevice:
    def __init__(self, hostname, ip_addr, hw_addr):
        self.hostname = hostname
        self.ip_addr = ip_addr
        self.hw_addr = hw_addr

    @staticmethod
    def deserialize(loader: FullLoader, node: MappingNode) -> NetworkDevice:
        """Deserialize a NetworkDevice object from YAML"""
        return NetworkDevice(**loader.construct_mapping(node))


add_constructor(
    "tag:yaml.org,2002:python/object:network.NetworkDevice", NetworkDevice.deserialize
)


def search_devices() -> list[NetworkDevice]:
    """Finds network devices with a ARP request."""
    logger.info("Searching for network devices.")

    request = scapy.ARP(pdst="192.168.1.0/24")
    broadcast = scapy.Ether(dst="ff:ff:ff:ff:ff:ff")

    request_broadcast = broadcast / request
    answers, _ = scapy.srp(request_broadcast, timeout=1, verbose=False)

    devices = []
    for client in answers:
        ip_addr = client[1].psrc
        hw_addr = client[1].hwsrc
        hostname = try_get_hostname(ip_addr)

        device = NetworkDevice(hostname, ip_addr, hw_addr)
        devices.append(device)

        logger.debug(f"Found: {ip_addr} ({hw_addr}) -> {hostname}")

    logger.info(f"Found {len(devices)} network devices.")
    return devices


def try_get_hostname(addr: str) -> str:
    """Attempts to find the hostname for an IP address, returns empty string if not found."""
    try:
        return gethostbyaddr(addr)[0]
    except:
        return ""
