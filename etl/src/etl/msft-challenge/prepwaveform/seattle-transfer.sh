#!/bin/bash

declare -A idlink
declare -A filelink

psql -d challenge -h $PGHOST -U postgres -qtA -f /tmp/seattle_idselect.sql > tmppersonmapmitseattle.txt
psql -d challenge -h $PGHOST -U postgres -qtA -f /tmp/seattle_shiftselect.sql > tmpfilemapseattle.txt


while IFS='|' read -r key value; do
    idlink[$key]=$value
done < tmppersonmapmitseattle.txt

while IFS='|' read -r key value; do
    filelink[$key]=$value
done < tmpfilemapseattle.txt

for i in "${!idlink[@]}"
do
  PERSON_ID="${idlink[$i]}"
  TRG_NAME="${filelink[$i]}"
  SRC_URL="https://choruspilotstorage.blob.core.windows.net/seattle/${i}?<SAS TOKEN>"
  TRG_URL="https://choruspilotstorage.blob.core.windows.net/msft-challenge/5/${PERSON_ID}/${TRG_NAME}?<SAS TOKEN>"
  echo "person: $PERSON_ID"
  echo "source: $i"
  echo "target: 2/$PERSON_ID/$TRG_NAME"
  #azcopy cp --output-level quiet --overwrite=false "${SRC_URL}" "${TRG_URL}"
done