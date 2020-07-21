import pandas
import numpy
import h5py
OLD="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/predixcan_family/predixcan_geuvadis_hg38_gtexv6/en/Adipose_Subcutaneous_predicted_expression.txt"
old_p_run = pandas.read_table(OLD)

NEW = "/scratch/abarbeira3/test/new_predixcan/en_geuv_v6/Adipose_Subcutaneous__predict.txt"
new_p_run = pandas.read_table(NEW)
g_genes_ = list(new_p_run.columns.values[2:])

#investigate ENSG00000152022.7 in old and new

#genes in the old run absent from the new one should be all zero (i.e. the old script generated an entry but didin't predict anythin

def check_zeroes(diff, run, label):
    for i, g in enumerate(diff):
        diff_ = numpy.sum(run[g].values)
        assert (diff_ == 0)
        # if diff_:
        #    from IPython import embed; embed(); exit()
def check(x, y, genes, label, dec=6):
    for i,g in enumerate(genes):
        numpy.testing.assert_array_almost_equal(x[g], y[g], decimal=dec)
        #if not numpy.allclose(x[g], y[g]):
        #    from IPython import embed; embed(); exit()

on_diff = [x for x in old_p_run.columns.values if not x in set(new_p_run.columns.values)]
check_zeroes(on_diff, old_p_run, "on")
old_p_run = old_p_run[["FID", "IID"] + g_genes_]
assert(old_p_run.shape[0] == new_p_run.shape[0])
assert(old_p_run.shape[1] == new_p_run.shape[1])
check(old_p_run, new_p_run, g_genes_, "on")


print("ok")

