#!/bin/bash

echo "Copying files from landing blobs to pilot FS"

azcopy cp --recursive "${LANDING_KEY}" "/midpoint"

echo "Storage move job complete! Printing logs and Exiting..."
