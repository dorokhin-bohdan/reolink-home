#!/bin/sh

set -e

path="$1"

if [ -z "$path" ]; then
  echo "The source path is not specified">&2
  exit 1
fi

jobName="cleanupReolink"
cleanupScriptName="cleanup.sh"
cleanupScriptPath="$(pwd)/$cleanupScriptName"
outputLogPath="$(pwd)/cleanup-log.txt"

echo "Allow executing file as program..."
chmod +x "$cleanupScriptName"
echo "Allowed"

echo "Removing old cron job..."
cru d "$jobName"
echo "Removed"

echo "Adding cron job with name '$jobName'..."
cru a $jobName "0 0 */1 * * $cleanupScriptPath $path > $outputLogPath"
echo "Added"