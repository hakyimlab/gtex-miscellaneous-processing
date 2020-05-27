import pandas
import numpy

def check_zeroes(diff, run, label):
    for i, g in enumerate(diff):
        diff_ = numpy.sum(run[g].values)
        assert (diff_ == 0)
        # if diff_:
        #    from IPython import embed; embed(); exit()
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

OLD="/scratch/abarbeira3/test/chr22_old_predixcan_vcfhg37_en/Whole_Blood_predicted_expression.txt"
old_p_run = pandas.read_table(OLD)

NEW="/scratch/abarbeira3/test/chr22_vcfhg37_en/Whole_Blood__predict.txt"
new_p_run = pandas.read_table(NEW)
g_genes_ = list(new_p_run.columns.values[2:])

on_diff = [x for x in old_p_run.columns.values if not x in set(new_p_run.columns.values)]
check_zeroes(on_diff, old_p_run, "on")
old_p_run = old_p_run[["FID", "IID"] + g_genes_]
assert(old_p_run.shape[0] == new_p_run.shape[0])
assert(old_p_run.shape[1] == new_p_run.shape[1])
check(old_p_run, new_p_run, g_genes_, "on")

#gene 'ENSG00000099991.17' is different: the difference is how old PrediXcan handles ambiguous alleles,
# there is a C/G variant in this model with v8