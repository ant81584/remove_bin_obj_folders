#!/bin/bash

# Script: remove_bin_obj.sh
# Description: This script removes the 'bin' and 'obj' folders from a specified directory and its subdirectories.
# Author: Anton Kalis
# Disclaimer: This script is provided as-is, without any warranty or guarantee. Use it at your own risk.

# Function to remove bin and obj folders
remove_bin_obj() {
    local dir="$1"
    if [ -d "$dir" ]; then
        echo "Removing bin and obj folders from $dir"
        find "$dir" -type d \( -name "bin" -o -name "obj" \) -exec rm -r {} +
    else
        echo "Directory $dir does not exist."
    fi
}


# Check if the start directory parameter is provided
if [ -z "$1" ]; then
    echo "Please provide the start directory."
    exit 1
fi

# Get the start directory from the command-line parameter to start removing bin and obj folders
start_directory="$1"

# Check if the start directory exists
if [ -d "$start_directory" ]; then
    # Call the function to remove bin and obj folders in the start directory
    remove_bin_obj "$start_directory"

    # Iterate through subdirectories
    while IFS= read -r -d '' sub_directory; do
        remove_bin_obj "$sub_directory"
    done < <(find "$start_directory" -type d -print0)
else
    echo "Start directory $start_directory does not exist."
fi
