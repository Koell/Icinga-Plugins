#!/bin/bash
#
# Speedtest for Icinga
#
# required: speedtest-cli
# author: Fabian Köll

#Icinga Exit-codes

EXIT_OK=0
EXIT_WARNING=1
EXIT_CRITICAL=2
EXIT_UNKOWN=3

EXIT_CODE=$EXIT_UNKNOWN
OUTPUT=""
PERFORMANCE=""

function finish {
    msg=""
    if [[ "$EXIT_CODE" == "$EXIT_UNKNOWN" ]]; then
        msg="UNKNOWN"
    elif [[ "$EXIT_CODE" == "$EXIT_CRITICAL" ]]; then
        msg="CRITICAL"
    elif [[ "$EXIT_CODE" == "$EXIT_WARNING" ]]; then
        msg="WARNING"
    elif [[ "$EXIT_CODE" == "$EXIT_OK" ]]; then
        msg="OK"
    fi
    
    if [[ -n $OUTPUT  ]]; then
        msg="$msg - $OUTPUT"
    fi
    
    if [[ -n $PERFORMANCE  ]]; then
        msg="$msg | $PERFORMANCE"
    fi
    
    
    echo $msg
    exit $EXIT_CODE
}

trap finish EXIT
trap finish SIGKILL
trap finish SIGTERM

# check - start
csv=$(speedtest --csv)

if [[ $csv == *"ERROR"* ]]; then
    EXIT_CODE=$EXIT_CRITICAL
    OUTPUT=$csv
    exit
fi


ping=$(echo $csv | cut -d ',' -f6)
down=$(echo $csv | cut -d ',' -f7 )
up=$(echo $csv | cut -d ',' -f8)
ip=$(echo $csv | cut -d ',' -f10)

down=${down%.*}
up=${up%.*}

OUTPUT="Download: $down bit/s, Upload: $up bit/s, Ping $ping ms"
PERFORMANCE="'download'=$down bit/s, 'up'=$up bit/s, 'ping'=$ping ms, 'ip'=$ip"

EXIT_CODE=$EXIT_OK

