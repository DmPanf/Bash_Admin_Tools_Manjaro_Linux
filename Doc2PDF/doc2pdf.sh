#!/bin/bash

# Initialize variables
# OPERATION holds the command used for converting .doc to .pdf
# SUFFIX holds the file extension for the output files
# directory holds the directory where the script will look for .doc files
OPERATION="docToPdf"
SUFFIX="pdf"
directory="$PWD"

# Check if the required command (docToPdf) exists on the system
if ! command -v "$OPERATION" &> /dev/null; then
  echo "Error: The $OPERATION command could not be found."
  exit 1
fi

# Iterate over each file in the specified directory
for file in "$directory"/*; do

  # Skip over directories
  if [[ -d "$file" ]]; then
    continue
  fi

  # Extract the filename without the extension and path
  filename=$(basename -- "$file")
  filename_no_ext="${filename%.doc}"

  # Skip files that don't have a .doc extension
  if [[ "$filename" == "$filename_no_ext" ]]; then
    continue
  fi

  # Generate the name for the output .pdf file
  output_file="$directory/$filename_no_ext.$SUFFIX"

  # Attempt to convert the .doc file to a .pdf file
  if "$OPERATION" "$file" > "$output_file"; then
    echo "Successfully converted $file to $output_file."
    rm -f "$file"
  else
    echo "Failed to convert $file. Skipping..."
  fi
done

# Output a final message to indicate successful completion of the script
echo "Conversion process completed."
