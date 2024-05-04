#!/bin/sh

path="$1"

set -e

if [ -z "$path" ]; then
    echo "The source path is not specified"
    exit 1
fi

jobName="cleanupReolink"

echo "Allow executing file as program..."
chmod +x ./cleanup.sh
echo "Allowed"

echo "Removing old cron job..."
cru d "$jobName"
echo "Removed"

echo "Adding cron job with name '$jobName'..."
cru a $jobName "0 0 */1 * * ./cleanup-reolink.sh $path > cleanup-log.txt"
echo "Added"