from os import makedirs, path
from pathlib import Path
from typing import List

from appdirs import AppDirs
from loguru import logger
from network import NetworkDevice
from yaml import FullLoader, dump, load

dirs = AppDirs("auto", "onnovalkering")


class Configuration:
    """ """

    def __init__(self) -> None:
        self.__file = Path(path.join(dirs.user_config_dir, "config.yml"))

        if self.__file.exists():
            with open(self.__file.absolute(), "r") as file:
                self.__config = load(file, Loader=FullLoader)
        else:
            self.__config = {}
            logger.debug("File doesn't exists, created empty configuration.")

    def exists(self) -> bool:
        return self.__file.exists()

    def save(self) -> None:
        if self.__config is None:
            return

        if not self.exists():
            parent = self.__file.parent.absolute()
            makedirs(parent)

        if self.__config is not None:
            with open(self.__file, "w") as file:
                dump(self.__config, file)

    @property
    def devices(self) -> List[NetworkDevice]:
        return self.__config["devices"]

    @devices.setter
    def devices(self, value):
        self.__config["devices"] = value
