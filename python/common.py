import sys
from enum import Enum


class ExitCode(Enum):
    OK = 0
    WARNING = 1
    CRITICAL = 2
    UNKNOWN = 3


def message(code: ExitCode, msg="", param=""):
    print(f"{code.name} - {msg}")
    sys.exit(code.value)
