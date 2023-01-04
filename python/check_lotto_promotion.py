#!/usr/bin/env python3


import basic
import requests


def check(name: str):
    r = requests.get('https://www.win2day.at/gewinner-des-tages')
    if r.text.find(name) != -1:
        basic.message(basic.ExitCode.CRITICAL)
    else:
        basic.message(basic.ExitCode.UNKNOWN)


check("koell")
