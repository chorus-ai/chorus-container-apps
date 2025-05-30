#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

export HOME=/app/sql-workbench
cd /app/sql-workbench

PIDS=

notify() {
    for N in $(ls /etc/logmonitor/targets.d/*/send)
    do
       "$N" "$1" "$2" "$3" &
       PIDS="$PIDS $!"
    done
}

# Verify support for membarrier.
if ! /usr/bin/membarrier_check 2>/dev/null; then
   notify "$APP_NAME requires the membarrier system call." "$APP_NAME is likely to crash because it requires the membarrier system call.  See the documentation of this Docker container to find out how this system call can be allowed." "WARNING"
fi

# Wait for all PIDs to terminate.
set +e
for PID in "$PIDS"; do
   wait $PID
done
set -e

java -jar sqlworkbench.jar -configDir=/export/configs/SQLWorkbench

# vim:ft=sh:ts=4:sw=4:et:sts=4
