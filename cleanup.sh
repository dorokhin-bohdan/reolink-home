#!/bin/sh

getOldestFolder() {
  sourcePath=$(echo "$1" | sed 's:/*$::')
  oldestFolderPath=$(ls -luArd -1 "$sourcePath"/* | grep "^d" | head -1 | awk '{print $NF}')

  if [ "$oldestFolderPath" ]; then
    echo "$oldestFolderPath"
    return 0
  fi

  echo "Unable to get oldest folder from '$sourcePath'.">&2
  exit 1
}

cleanupOldRecords() {
  recordsFolder="$1"

  if rm -fR "$recordsFolder"; then
    echo "The '$recordsFolder' was deleted."
  fi
}

removeEmptyFolder() {
  path="$1"

  if rmdir "$path"; then
    echo "The empty folder with path '$path' was deleted."
  fi
}

set -e

echo "Starting cleaning of old records from Reolink cameras..."
echo "Date: $(date)"

reolinkFolderPath=$1

if [ ! -d "$reolinkFolderPath" ]; then
  echo "The source path '$reolinkFolderPath' not found.">&2
fi

echo "Source path: $reolinkFolderPath"

oldestYearFolderPath=$(getOldestFolder "$reolinkFolderPath")
echo "Year folder: $oldestYearFolderPath"

oldestMonthFolderPath=$(getOldestFolder "$oldestYearFolderPath")
echo "Month folder: $oldestMonthFolderPath"

oldestDayFolderPath=$(getOldestFolder "$oldestMonthFolderPath")
echo "Day folder: $oldestDayFolderPath"

cleanupOldRecords "$oldestDayFolderPath"
removeEmptyFolder "$oldestMonthFolderPath"
removeEmptyFolder "$oldestYearFolderPath"
