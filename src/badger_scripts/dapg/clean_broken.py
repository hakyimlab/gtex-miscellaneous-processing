__author__ = "alvaro barbeira"
import os
import shutil
import pandas
import glob
import traceback

d = pandas.read_table("check.txt")
d = d[~d.complete]

def _d(x):
    if os.path.exists(x):
        shutil.rmtree(x)

for t in d.itertuples():
    n = t.job_name.split("_gtexv8")[0]
    print(n)
    try:
        _d(os.path.join("results/dapg_maf0.01_w1000000", n))

        _d(os.path.join("scratch_dapg", n.replace("chr", "")))
        _d(os.path.join("scratch_dapg", n))

        l = glob.glob(os.path.join("logs_dap", n+"*"))
        for l_ in l:
            os.remove(l_)
        os.remove(t.job_path)

    except Exception as e:
        traceback.print_exc()