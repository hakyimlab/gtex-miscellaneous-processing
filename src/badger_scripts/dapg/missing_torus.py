__author__ = "alvaro barbeira"
import os

F="results/torus_prior"
folders = sorted(os.listdir(F))
for f in folders:
    if not os.path.exists(os.path.join(F,f,"priors")):
        print(f.split(".v8")[0])

