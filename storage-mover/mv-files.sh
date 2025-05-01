#!/bin/bash

echo "Copying files from landing storage to midpoint FS"

L2M=$("azcopy cp --recursive \"${LANDING_KEY}\" /midpoint")

if [[ $L2M == *"Final Job Status: Completed"* ]]; then
  echo "Copy to midpoint completed successfully! Removing files in landing storage..."
  RML=$("azcopy remove --recursive \"${LANDING_KEY}\"")
  if [[ $RML == *"Final Job Status: Completed"* ]]; then
    echo "Landing file(s) removed! Launching copy from midpoint to secure storage..."
  fi
fi

M2P=$("azcopy cp --recursive /midpoint/* \"${PILOT_KEY}\"")

if [[ $M2P == *"Final Job Status: Completed"* ]]; then
  echo "Copy from midpoint completed successfully! Removing files in midpoint..."
  rm -rf /midpoint/*
fi

echo "Storage move job complete! Exiting..."