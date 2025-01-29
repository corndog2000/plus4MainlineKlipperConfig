#!/bin/bash

# Directory where the master macro file is stored
MASTER_DIR="/home/mks/src/plus4MainlineKlipperConfig/config"

# Directory where individual macro files should be saved
OUTPUT_DIR="/home/mks/src/plus4MainlineKlipperConfig/config/macros"

# Master file name
MASTER_FILE="${1:-gcode_macro.cfg}"

# Ensure the output directory exists, if not, create it
mkdir -p "$OUTPUT_DIR"

# Pattern to identify the start of a macro
START_PATTERN="^\[gcode_macro"

# Initialize a variable to hold the current macro content
current_macro=""

# Variable to keep track of the name of the current macro file
current_filename=""

# Variable to store potential comments preceding a macro
comment_block=""

# Read the master macro file line by line
while IFS= read -r line || [[ -n "$line" ]]
do
    # Check if the line is a comment
    if [[ "$line" =~ ^#.* ]]; then
        # Accumulate comments, in case the next line starts a macro
        comment_block+="$line
"
    elif [[ "$line" =~ $START_PATTERN ]]; then
        # Check if we are already collecting a macro
        if [[ -n $current_macro ]]; then
            # Write the current macro to a file before starting a new one
            echo -e "$current_macro" > "$OUTPUT_DIR/$current_filename"
            echo "Saved $current_filename"
        fi
        # Start collecting a new macro, include preceding comments
        current_macro="$comment_block$line"
        # Extract the macro name and create a file name
	macro_name=$(echo "$line" | awk '{print substr($2, 1, length($2)-1)}')
        current_filename="${macro_name}.cfg"
        # Reset comment block for the next macro
        comment_block=""
    else
        # Continue accumulating macro or reset comments if not directly before macro
        if [[ -n $current_macro ]]; then
            current_macro+="
$line"
        else
            # Reset comment block if the comments are not directly followed by a macro
            comment_block=""
        fi
    fi
done < "$MASTER_DIR/$MASTER_FILE"

# Don't forget to save the last macro read from file
if [[ -n $current_macro ]]; then
    echo -e "$current_macro" > "$OUTPUT_DIR/$current_filename"
    echo "Saved $current_filename"
fi

echo "Macro breakout complete."

