#!/usr/bin/env bash

q
for f in $F/*; do
    echo $f
    cat $f | head -1
done