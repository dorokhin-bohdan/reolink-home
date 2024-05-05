#!/bin/sh

path="$1"

set -e

if [ -z "$path" ]; then
    echo "The source path is not specified"
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