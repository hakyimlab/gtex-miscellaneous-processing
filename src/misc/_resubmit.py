#!/usr/bin/env python
__author__ = "alvaro barbeira"

import os
import re
import time

from subprocess import call

r_ = re.compile("logs/(.*).e([0-9]+).cri(.*).err")

list = []
with open("kkk.txt") as f:
    for l in f:
        l = r_.search(l).group(1)
        list.append(l)

jobs = [os.path.join("old/jobs_summary_imputation", x)+ ".sh" for x in list]


for j in jobs:
    print(j)
    call(["qsub", j])
    time.sleep(0.1)