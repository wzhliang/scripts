#!/bin/sh
# Shell script for building PyQt examples. Run at "example" level
rc_files=$(find . -name "*.qrc")
for rc in $rc_files;
do
    p=$(dirname $rc)
    n=$(basename $rc .qrc)
    pyrcc4 -o $p/${n}_rc.py $rc
done
