#!/bin/bash

echo "Copying files from landing storage to midpoint FS"

L2M=$(azcopy cp --recursive "${LANDING_KEY}" "/midpoint")

if [[ $L2M == *"Final Job Status: Completed"* ]] && [[ $L2M != *"Final Job Status: CompletedWithErrors"* ]]; then
  echo "Copy to midpoint completed successfully! Removing files in landing storage..."
  RML=$(azcopy remove --recursive --exclude-pattern="*.db" "${LANDING_KEY}")
  if [[ $RML == *"Final Job Status: Completed"* ]] && [[ $RML != *"Final Job Status: CompletedWithErrors"* ]]; then
    echo "Landing file(s) removed! Launching copy from midpoint to secure storage..."
    else
      echo "$RML"
      exit 1
  fi
  else
    echo "$L2M"
    exit 1
fi

M2P=$(azcopy cp --recursive "/midpoint/*" "${PILOT_KEY}")

if [[ $M2P == *"Final Job Status: Completed"* ]] && [[ $M2P != *"Final Job Status: CompletedWithErrors"* ]]; then
  echo "Copy from midpoint completed successfully! Removing files in midpoint..."
  rm -rf /midpoint/*
  else
    echo "$M2P"
    exit 1
fi

echo "Storage move job complete! Printing logs and Exiting..."
