#!/bin/sh

getOldestDirectory() {
  sourcePath=$(echo "$1" | sed 's:/*$::')
  oldestDirectoryPath=$(ls -luArd -1 "$sourcePath"/* | grep "^d" | head -1 | awk '{print $NF}')

  if [ "$oldestDirectoryPath" ]; then
    echo "$oldestDirectoryPath"
    return 0
  fi

  echo "Unable to get oldest directory from '$sourcePath'.">&2
  exit 1
}

cleanupOldRecords() {
  recordsDirectory="$1"

  if rm -fR "$recordsDirectory"; then
    echo "The '$recordsDirectory' was deleted."
  fi
}

removeDirectoryIfEmpty() {
  path="$1"

  if [ "$(ls -A "$path")" ]; then
    echo "The directory with path '$path' is not empty."
    return 0
  fi

  if rmdir "$path"; then
    echo "The directory with path '$path' was deleted."
    return 0
  fi

  echo "Unable to delete directory with path '$path'"
}

ensureDirectoryExists() {
  directoryPath="$1"

  if [ ! -d "$directoryPath" ]
  then
    echo "The directory with path '$reolinkDirectoryPath' not found.">&2
    exit 1
  fi
}

set -e

echo "Starting cleaning of old records from Reolink cameras..."
echo "Date: $(date)"

reolinkDirectoryPath="$1"

if [ -z "$reolinkDirectoryPath" ]; then
  echo "The Reolink directory path is not specified">&2
  exit 1
fi

ensureDirectoryExists $reolinkDirectoryPath
echo "Source path: $reolinkDirectoryPath"

oldestYearDirectoryPath=$(getOldestDirectory "$reolinkDirectoryPath")
echo "Year directory: $oldestYearDirectoryPath"

oldestMonthDirectoryPath=$(getOldestDirectory "$oldestYearDirectoryPath")
echo "Month directory: $oldestMonthDirectoryPath"

oldestDayDirectoryPath=$(getOldestDirectory "$oldestMonthDirectoryPath")
echo "Day directory: $oldestDayDirectoryPath"

cleanupOldRecords "$oldestDayDirectoryPath"
removeDirectoryIfEmpty "$oldestMonthDirectoryPath"
removeDirectoryIfEmpty "$oldestYearDirectoryPath"
