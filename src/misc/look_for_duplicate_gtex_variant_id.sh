#!/usr/bin/env bash

CHECK()
{
zcat $1 | cut -f2 | sort | uniq -c | awk '$1==2' > $2
}

CHECK I O