#!/bin/sh

# Function: print_dir
# Purpose: Prints the current directory name and its symlink if it's a symlink.
# Parameters: The directory name
print_dir() {
    local indent=0  # Initialize indentation counter
    
    # Loop to print indentation based on nesting level
    while [ $indent != $deep ]; do
        echo -n "|   "  # Output vertical bar and spaces for indentation
        indent=$((indent + 1))
    done

    # Check if directory is a symlink
    if [ -L "$1" ]; then
        # If it is, print its name and where it points to
        echo "+---$1" $(ls -l "$1" | awk -F '->' '{print $2}')
    else
        # Else, just print its name
        echo "+---$1"
    fi
}

# Function: search
# Purpose: Recursively search through directories and print their structure.
search() {
    # Loop through all files and directories in the current directory
    for dir in $(echo *); do
        # Check if it is a directory
        if [ -d "$dir" ]; then
            # Print directory name using the helper function
            print_dir "$dir"

            # Try changing into the directory
            if cd "$dir" 2>/dev/null; then
                # Increase the depth counter for nesting
                deep=$((deep + 1))
                
                # Recursive call to search sub-directories
                search
                
                # Navigate back to parent directory
                cd ..
                
                # Decrease depth counter
                deep=$((deep - 1))
                
                # Increase the total directory count
                numdirs=$((numdirs + 1))
            fi
        fi
    done
}

# Function: main
# Purpose: The main function where execution starts.
main() {
    local start_dir  # Declare variable to store the starting directory

    # Check if a directory argument is provided
    if [ $# -eq 0 ]; then
        start_dir=$(pwd)  # Use the current directory if not provided
    else
        start_dir="$1"    # Else, use the provided argument
    fi

    # Change to the starting directory or exit if it doesn't exist
    cd "$start_dir" || { echo "Directory not found."; exit 1; }

    # Print the starting directory
    echo "Starting directory = $(pwd)"

    deep=0      # Initialize depth counter
    numdirs=0   # Initialize total directory counter

    # Start searching from the current directory
    search

    # Print total number of directories traversed
    echo "Total number of directories = $numdirs"
}

# Start the script by calling the main function and passing all arguments to it
main "$@"
