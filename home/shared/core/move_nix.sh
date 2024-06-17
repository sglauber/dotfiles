#!/usr/bin/env bash

# Loop through all .nix files in the current directory
for file in *.nix; 
do 
    # Extract the filename without the extension
    dir_name="${file%.nix}"
    
    # Create a directory named after the file (without the extension)
    mkdir -p "$dir_name"
    
    # Move the file into the newly created directory and rename it to default.nix
    mv "$file" "$dir_name/default.nix"
done
