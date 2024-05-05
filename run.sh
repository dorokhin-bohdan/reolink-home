#!/bin/sh

set -e

path="$1"

if [ -z "$path" ]; then
  echo "The source path is not specified">&2
  exit 1
fi

jobName="cleanupReolink"
cleanupScript="./cleanup.sh"

echo "Allow executing file as program..."
chmod +x "$cleanupScript"
echo "Allowed"

echo "Removing old cron job..."
cru d "$jobName"
echo "Removed"

echo "Adding cron job with name '$jobName'..."
cru a $jobName "0 0 */1 * * $cleanupScript $path > cleanup-log.txt"
echo "Added"