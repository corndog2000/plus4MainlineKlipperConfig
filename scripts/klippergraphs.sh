#!/usr/bin/env bash

GRAPHS="$HOME/klippergraphs"
KLIPHOME="$HOME/klipper"
KLIPLOGS="$HOME/printer_data/logs/klippy.log"
KLIPENV="$HOME/klippy-env/bin"

source $KLIPENV/activate

if [ ! -d $GRAPHS ]; then
    mkdir $GRAPHS
fi

$KLIPHOME/scripts/graphstats.py $KLIPLOGS -o $GRAPHS/loadgraph_host.png
$KLIPHOME/scripts/graphstats.py $KLIPLOGS -o $GRAPHS/loadgraph_mcu.png -s
$KLIPHOME/scripts/graphstats.py $KLIPLOGS -o $GRAPHS/loadgraph_extruder.png -t extruder
$KLIPHOME/scripts/graphstats.py $KLIPLOGS -o $GRAPHS/loadgraph_freq.png -f
