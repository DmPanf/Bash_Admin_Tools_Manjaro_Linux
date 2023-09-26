#!/bin/bash

# Check if exactly two arguments are passed to the script.
if [[ $# != 2 ]]; then
  echo "Usage: backup.sh target_directory_name destination_directory_name"
  exit 1
fi

# Check if the provided paths for the target and destination directories exist.
if [[ ! -d $1 ]] || [[ ! -d $2 ]]; then
  echo "Invalid directory path provided"
  exit 1
fi

# Assign arguments to meaningful variable names
targetDirectory="$1"
destinationDirectory="$2"

# Print out which directories are going to be involved in the backup
echo "📤 The Target Directory is $targetDirectory"
echo "📥 The Destination Directory is $destinationDirectory"

# Get the current timestamp in seconds since 1970-01-01 00:00:00 UTC.
currentTS=$(date +%s)

# Construct the backup file name using the timestamp.
backupFileName="backup-${currentTS}.tar.gz"

# Save the current working directory.
origAbsPath=$(pwd)

# Navigate to the destination directory and store its absolute path.
cd "$destinationDirectory" || { echo "Destination directory does not exist."; exit 1; }
destDirAbsPath=$(pwd)

# Navigate back to the original directory and then into the target directory.
cd "$origAbsPath" 
cd "$targetDirectory" 

# Calculate the timestamp for the same time 24 hours ago.
yesterdayTS=$(($currentTS - 24 * 60 * 60))

# Initialize an array to hold files that will be backed up.
declare -a toBackup

# Loop over each file in the target directory to check its last modified date.
for file in $(ls); do
  file_last_modified_date=$(date -r "$file" +%s)
  if [[ $file_last_modified_date -gt $yesterdayTS ]]; then
    toBackup+=("$file")
  fi
done

# Create a tarball (compressed archive) containing the files to be backed up.
tar -czvf "$backupFileName" "${toBackup[@]}"

# Move the tarball to the destination directory.
mv "$backupFileName" "$destDirAbsPath"

# Output summary of actions taken.
echo "✅ Project completed successfully!"
echo "📂 Backup of files has been completed."
echo "📦 Archive saved in the directory: $destDirAbsPath/$backupFileName"
echo "💼 All files updated in the last 24 hours have been included in the archive."
