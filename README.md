# Overview
This is a public first attempt to get the plus 4 working on mainline klipper or kalico.

## Additional Testing Once Flashed & Fixes
* Validate that filament cutting isn't causing false y home positions
* Validate heater and heater fan functionality
* optimize macros across many files

## Scripts Directory
These are just a few scripts I am using to manage code from my source directory and the
printer working config directory. Not required for anything qidi related and are purely
here to capture my tooling for the project.
* klippdif.sh - a tool to review and pull changes in the working printer config directory to
the source controlled directory.
* updateConfigs.sh - a tool to nuke all configs in the working printer config directory
and installing them from the source controlled directory.
