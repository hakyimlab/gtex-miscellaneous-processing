__author__ = "alvaro barbeira"
import pandas
import subprocess
import os
import re


d = pandas.read_table("/scratch/abarbeira3/v8_process/CTIMP_2/check_eqtl.txt")
d = d[d.complete == False]
for t in d.itertuples():
    #os.remove(t.log_path)
    stem = os.path.split(t.log_path)[1].split("_model_training")[0]
    from IPython import embed; embed(); exit()
    print("removing logs")
    subprocess.call(["rm", os.path.join("logs","stem")+"*"])

    stem = os.path.join("results_hapmap", stem)
    if os.path.exists(stem+ "_Adipose_Subcutaneous_covariance.txt.gz"):
        print("removing leftovers")
        subprocess.call(["rm", stem+"*"])
    else:
        print("No left overs")

    print("submitting")
    subprocess.call(["qsub", t.job_path])

