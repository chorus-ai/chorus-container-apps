#!/bin/bash

declare -A idlink


while IFS=',' read -r key value; do
    idlink[$key]=$value
done < mgh-transfer-60.csv

for i in "${!idlink[@]}"
do
  NEW_NAME="${idlink[$i]}"
  SRC_URL="https://mghb2ai.file.core.windows.net/extracts/wave-2/${NEW_NAME}?<SAS>"
  TRG_URL="https://mghb2ai.blob.core.windows.net/aimahead-60/data-assets/${NEW_NAME}?<SAS>"
  echo "source: $SRC_URL"
  echo "target: $TRG_URL"
  azcopy cp --overwrite=false "${SRC_URL}" "${TRG_URL}"
  #azcopy cp --output-level quiet --overwrite=false "${SRC_URL}" "${TRG_URL}"
  #sleep 1
done