#!/bin/bash

declare -A idlink
declare -A filelink

psql -d challenge -h $PGHOST -U postgres -qtA -f /tmp/mit_idselect.sql > tmppersonmapmit.txt
psql -d challenge -h $PGHOST -U postgres -qtA -f /tmp/mit_shiftselect.sql > tmpfilemapmit.txt


while IFS='|' read -r key value; do
    idlink[$key]=$value
done < tmppersonmapmit.txt

while IFS='|' read -r key value; do
    filelink[$key]=$value
done < tmpfilemapmit.txt

for i in "${!idlink[@]}"
do
  PERSON_ID="${idlink[$i]}"
  TRG_NAME="${filelink[$i]}"
  SRC_URL="https://choruspilotstorage.blob.core.windows.net/mit/${i}?<SAS TOKEN>"
  TRG_URL="https://choruspilotstorage.blob.core.windows.net/msft-challenge/2/${PERSON_ID}/${TRG_NAME}?<SAS TOKEN>"
  echo "person: $PERSON_ID"
  echo "source: $i"
  echo "target: 2/$PERSON_ID/$TRG_NAME"
  azcopy cp --output-level quiet --overwrite=false "${SRC_URL}" "${TRG_URL}"
done