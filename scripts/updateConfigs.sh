#!/bin/bash

# stop klipper
sudo systemctl stop klipper

# nuke config dir
rm -Rf ~/printer_data/config

# Copy the config dir
cp -R ~/src/plus4MainlineKlipperConfig/config ~/printer_data/

# start klipper
sudo systemctl start klipper
