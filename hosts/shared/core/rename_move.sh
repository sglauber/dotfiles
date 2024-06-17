#!/usr/bin/env bash

# Iterate over each .nix file in the current directory
for file in *.nix; do
  # Extract the base name of the file (without the .nix extension)
  folder_name="${file%.nix}"
  
  # Create a directory with the base name
  mkdir -p "$folder_name"
  
  # Move the file into the newly created directory and rename it to default.nix
  mv "$file" "$folder_name/default.nix"
done
