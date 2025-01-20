#!/bin/bash

declare -A idlink
declare -A filelink

psql -d challenge -h $PGHOST -U postgres -qtA -f /tmp/mgh_idselect.sql   > tmppersonmapmgh.txt
psql -d challenge -h $PGHOST -U postgres -qtA -f /tmp/mgh_shiftselect.sql > tmpfilemapmgh.txt

while IFS='|' read -r key value; do
    idlink[$key]=$value
done < tmppersonmapmgh.txt

while IFS='|' read -r key value; do
    filelink[$key]=$value
done < tmpfilemapmgh.txt

for i in "${!idlink[@]}"
do
  PERSON_ID="${idlink[$i]}"
  TRG_NAME="${filelink[$i]}"
  SRC_URL="https://choruspilotstorage.blob.core.windows.net/mgh/${i}?<SAS TOKEN>"
  TRG_URL="https://choruspilotstorage.blob.core.windows.net/aimahead/1/${PERSON_ID}/${TRG_NAME}?<SAS TOKEN>"
  echo "patient  : $PERSON_ID"
  echo "source: $i"
  echo "target: 1/$PERSON_ID/$TRG_NAME"
  azcopy cp --output-level quiet --overwrite=false "${SRC_URL}" "${TRG_URL}"
done