#!/bin/bash

# Define directories
CODE_DIR=~/src/plus4MainlineKlipperConfig/config
PRINTER_DIR=/home/mks/printer_data/config

# Function to display help
function display_help() {
    echo "Usage: $0 [option] [file_name]"
    echo
    echo "Options:"
    echo "  -h, --help       Display this help message and exit"
    echo "  file_name        Specify the name of the file to compare (e.g., printer.cfg)"
    echo
    echo "If no file_name is provided, the script performs a recursive comparison"
    echo "of all files in the specified directories."
    echo
    echo "Examples:"
    echo "  $0 printer.cfg   Compare a specific file named printer.cfg"
    echo "  $0               Perform a recursive comparison of all files"
}

# Prompt user to copy file
function prompt_and_copy() {
    echo "Do you want to copy '$1' from $PRINTER_DIR to $CODE_DIR? (yes/no)"
    read answer
    if [[ "$answer" == "yes" ]]; then
        cp "$PRINTER_DIR/$1" "$CODE_DIR/$1"
        echo "File '$1' copied successfully."
    else
        echo "Copy operation cancelled."
    fi
}

# Check for help option
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    display_help
    exit 0
fi

# Check if a file name is provided
if [ "$#" -eq 1 ]; then
    # Specific file comparison
    FILE_NAME=$1
    if diff -u "$CODE_DIR/$FILE_NAME" "$PRINTER_DIR/$FILE_NAME"; then
        echo "No differences found."
    else
        prompt_and_copy "$FILE_NAME"
    fi
else
    # Recursive comparison of all files
    if diff -ur "$CODE_DIR" "$PRINTER_DIR"; then
        echo "No differences found."
    else
        echo "Differences detected. Run the script with specific file names to copy individual files."
    fi
fi
