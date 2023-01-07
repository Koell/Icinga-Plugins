#!/usr/bin/env python3


import common
import requests


def check(name: str):
    r = requests.get('https://www.win2day.at/gewinner-des-tages')
    if r.text.find(name) != -1:
        common.message(common.ExitCode.CRITICAL, "You won")
    else:
        common.message(common.ExitCode.UNKNOWN, "Not selectedd")


check("koell")
