import pandas
import numpy
import sqlite3

old = pandas.read_table("/scratch/abarbeira3/test/kk/capture_old.txt.gz").rename(columns={"ref_allele":"eff_allele", "allele":"a1"})
new = pandas.read_table("/scratch/abarbeira3/test/kk/capture_new.txt.gz")
old_ = old[["gene", "weight", "variant_id", "eff_allele", "a1", "allele_align"]]
new_ = new[["gene", "weight", "variant_id", "ref_allele", "eff_allele", "a0", "a1", "strand_align", "allele_align"]]
m = old_.merge(new_, on=["gene","variant_id"])
gene = new.gene[0]

MODEL="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/models_v1/eqtl/elastic_net_models/en_Whole_Blood.db"
with sqlite3.connect(MODEL) as conn:
    weights = pandas.read_sql("SELECT * FROM WEIGHTS", conn)

m[(m.eff_allele_x != m.eff_allele_y) | (m.a1_x != m.a1_y)]
for i in range(0,2504):
    x = new["ID_{}".format(i)]
    y = old["ID_{}".format(i)]
    numpy.testing.assert_array_almost_equal(x,y)

old_g = old.drop(["gene", "weight", "variant_id", "eff_allele", "a1"], axis=1)
new_g = new.drop(["gene", "weight", "variant_id", "ref_allele", "eff_allele", "a0", "a1"], axis =1)

from IPython import embed; embed(); exit()

m[m.allele_align_x != m.allele_align_y][["variant_id", "ref_allele", "eff_allele_x", "eff_allele_y", "a1_x", "a1_y", "strand_align", "allele_align_x", "allele_align_y"]]
weights[(weights.gene == 'ENSG00000099991.17') & (weights.rsid == "rs2330722")]