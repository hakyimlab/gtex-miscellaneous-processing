__author__ = "alvaro barbeira"
import shutil
import os

F="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models/mashr_models"
files = [x for x in os.listdir(F) if ".txt.gz" in x]

for f in files:
    i = os.path.join(F,f)
    o = os.path.join(F, "mashr_"+f)
    shutil.move(i, o)

