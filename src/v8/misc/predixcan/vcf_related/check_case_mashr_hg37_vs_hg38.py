import pandas
import numpy
import sqlite3

old = pandas.read_table("/scratch/abarbeira3/test/mashr_capture/capture_old_p.txt.gz").rename(columns={"ref_allele":"eff_allele", "allele":"a1"})
new = pandas.read_table("/scratch/abarbeira3/test/mashr_capture/capture_new_p.txt.gz")
old_ = old[["gene", "weight", "variant_id", "eff_allele", "a1", "allele_align"]]
new_ = new[["gene", "weight", "variant_id", "ref_allele", "eff_allele", "a0", "a1", "strand_align", "allele_align"]]
m = old_.merge(new_, on=["gene","variant_id"])
gene = new.gene[0]

MODEL="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/mashr/mashr_Whole_Blood.db"
with sqlite3.connect(MODEL) as conn:
    weights = pandas.read_sql("SELECT * FROM WEIGHTS", conn)

m[(m.eff_allele_x != m.eff_allele_y) | (m.a1_x != m.a1_y)]

old_g = old.drop(["gene", "weight", "variant_id", "eff_allele", "a1"], axis=1)
new_g = new.drop(["gene", "weight", "variant_id", "ref_allele", "eff_allele", "a0", "a1"], axis =1)
intersection = [x for x in new_g.columns.values if x in old_g.columns.values]

d=[]
for g in intersection:
    x = new[g]
    y = old[g]
    diff = numpy.sum(x-y)
    if diff !=0:
        d.append((g, diff))
    #numpy.testing.assert_array_almost_equal(x,y)

from IPython import embed; embed(); exit()

m[["variant_id", "weight_x", "weight_y"]]

m[["variant_id", "ref_allele", "eff_allele_x", "eff_allele_y", "a1_x", "a1_y", "strand_align", "allele_align_x", "allele_align_y"]]
weights[(weights.gene == 'ENSG00000075218.18') & (weights.rsid.isin(old_.variant_id))]