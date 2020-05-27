import pandas
import os
import sqlite3

G="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage"

def read_d(folder):
    files = [x for x in os.listdir(folder) if ".gz" in x]
    d = []
    for f in files:
        print(f)
        d_ = pandas.read_table(os.path.join(folder, f), header=None, usecols=[0,1,2,3,4,5], names=["chromosome", "variant_id", "position", "a0", "a1", "f"])
        d.append(d_)
    d = pandas.concat(d)
    return d
variants = read_d(G)

DB="/gpfs/data/im-lab/nas40t2/abarbeira/data/metaxcan/GTEx-V6p-HapMap-2016-09-08/TW_Adipose_Subcutaneous_0.5.db"
def read_db(p):
    with sqlite3.connect(p) as connection:
        cursor = connection.cursor()
        r = cursor.execute("select gene, rsid, weight, ref_allele, eff_allele FROM weights")
        w = pandas.DataFrame(list(r), columns =["gene", "variant_id", "weight", "ref_allele", "eff_allele"])

        r = cursor.execute("select gene, `n.snps.in.model` FROM extra")
        e = pandas.DataFrame(list(r), columns =["gene", "n_snps_in_model"])
        return  w, e

weights, extra = read_db(DB)

# this check
#w_ = weights[weights.gene == "ENSG00000152022.7"]
#check = w_.join(variants, on="variant_id")
#                 gene  variant_id    weight ref_allele eff_allele  chromosome   position a0 a1         f
# 0  ENSG00000152022.7    rs600646 -0.217428          T          C           1  149033329  G  A  0.199413
# 1  ENSG00000152022.7  rs10910821  0.010263          G          A           1  145918026  T  C  0.052786


from IPython import embed; embed(); exit()

# w_ = weights[weights.gene =='ENSG00000116688.12']
# check = w_.merge(variants, on="variant_id")
# this row is the suspicious one, it would seem there is weight sign difference in odl vs new code
#  ENSG00000116688.12   rs7517886  0.015748          A          G           1  12539549  G  A  0.313783


w_ = weights[weights.gene =='ENSG00000131795.8']
check = w_.merge(variants, on="variant_id")