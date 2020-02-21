import pandas

old = pandas.read_table("/scratch/abarbeira3/kk/kk/capture_old.txt.gz").rename(columns={"ref_allele":"eff_allele", "allele":"a1"})
new = pandas.read_table("/scratch/abarbeira3/kk/kk/capture_new.txt.gz")
m = old[["gene", "weight", "variant_id", "eff_allele", "a1"]].\
    merge(new[["gene", "weight", "variant_id", "ref_allele", "eff_allele", "a0", "a1"]], on="variant_id")
from IPython import embed; embed(); exit()

old_ = old.drop(["gene", "weight", "variant_id", "eff_allele", "a1"], axis=1)
new_ = new.drop(["gene", "weight", "variant_id", "ref_allele", "eff_allele", "a0", "a1"], axis =1)