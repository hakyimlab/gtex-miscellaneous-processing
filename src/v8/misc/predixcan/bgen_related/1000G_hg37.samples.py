from cyvcf2 import VCF
import pandas
I="/scratch/abarbeira3/data/1000G_hg37/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz"
S="/scratch/abarbeira3/data/1000G_hg37_dosage/samples.txt"
v = VCF(I)
ids = [(x, x) for x in v.samples]
ids = pandas.DataFrame(ids, columns=["FID", "IID"])
ids.to_csv(S, header=False, sep=" ", index=False, na_rep="NA")