#!/bin/bash

echo "Copying files from pilot blobs to pilot FS"

azcopy cp --recursive "${PILOT_KEY}" "/midpoint"

echo "Storage move job complete! Printing logs and Exiting..."
