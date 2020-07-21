import pandas
import numpy

def check_zeroes(diff, run, label):
    d_=[]
    for i, g in enumerate(diff):
        diff_ = numpy.sum(run[g].values)

        #assert (diff_ == 0)
        if diff_:
            d_.append((g, diff_))
    print("{}:{} out of {} have zero difference".format(label, len(d_)))

def check(x, y, genes, label, dec=6):
    diff=0
    for i,g in enumerate(genes):
        #numpy.testing.assert_array_almost_equal(x[g], y[g], decimal=dec)
        if not numpy.allclose(x[g], y[g]):
            diff+=1
            #from IPython import embed; embed(); exit()
    print("{} out of {} differ".format(diff, len(genes)))
    #numpy.testing.assert_equal(diff, 0)
###

OLD="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/predixcan_geuvadis_hg38_v1/mashr/Whole_Blood_predicted_expression.txt"
_old_p_run = pandas.read_table(OLD)

NEW="/scratch/abarbeira3/test/geuv_vcfhg37_mashr/Whole_Blood__predict.txt"
new_p_run = pandas.read_table(NEW)
g_genes_ = list(new_p_run.columns.values[2:])

on_diff = [x for x in _old_p_run.columns.values if not x in set(new_p_run.columns.values)]
#check_zeroes(on_diff, old_p_run, "on")
old_p_run = _old_p_run[["FID", "IID"] + g_genes_]


d = []
for g in g_genes_:
    x_ = new_p_run[["IID", g]].rename(columns={g:"x"})
    y_ = old_p_run[["IID", g]].rename(columns={g:"y"})
    m = x_.merge(y_, on="IID")
    diff = numpy.sum(m.x.values - m.y.values)
    if diff > 0:
        d.append((g, diff))

from IPython import embed; embed(); exit()
#assert(old_p_run.shape[0] == new_p_run.shape[0])
#assert(old_p_run.shape[1] == new_p_run.shape[1])
#check(old_p_run, new_p_run, g_genes_, "on")