__author__ = "alvaro barbeira"
import os
import shutil

I="/scratch/abarbeira3/v8_process/enloc/sqtl/results"
O="/scratch/abarbeira3/v8_process/enloc/sqtl/results_keep"
if not os.path.exists(O):
    os.makedirs(O)
contents = sorted(os.listdir(I))

for f in contents:
    print(f)
    f_ = os.path.join(I,f)
    if ".txt.gz" in f:
        print("removing")
        shutil.rmtree(f_)

    trait = f.split("__PM__")[0]

    results = {x for x in os.listdir(f_)}
    enloc = trait+".enloc.rst"
    enrich = trait+".enrich.est"

    #temp:
    if enloc in results:
        print("removing pip stuff")
        os.remove(os.path.join(f_,"qtl.pip"))
        shutil.rmtree(os.path.join(f_, "priors"))
        shutil.rmtree(os.path.join(f_, "mi"))
        shutil.rmtree(os.path.join(f_, "qtl_pip"))
    continue

    if enloc in results and enrich in results:
        print("rescuing")
        shutil.move(os.path.join(f_, enloc), os.path.join(O, enloc))
        shutil.move(os.path.join(f_, enrich), os.path.join(O, enrich))
        print("cleaning up")
        shutil.rmtree(f_)
        continue

    print("skipping")



