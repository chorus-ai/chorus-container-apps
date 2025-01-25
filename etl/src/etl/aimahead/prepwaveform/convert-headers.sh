#!/bin/bash

for file in wave-2/4/*/*/*/*.hea; do
    NEWNAME=$(basename $(echo "${file%.hea}"))
    OLDNAME=$(head -n 1 $file | cut -d " " -f1)
    echo "Old: $OLDNAME, New: $NEWNAME"
    sed -i "s/$OLDNAME/$NEWNAME/g" $file
    echo "Header modified!"
done