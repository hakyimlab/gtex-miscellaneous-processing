import vcf
import io
import gzip
#gtex = "/gpfs/data/gtex-group/v8/59348/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.SHAPEIT2_phased.vcf.gz"
#vcf_reader = vcf.Reader(io.TextIOWrapper(gzip.open(example)), "r")
#r = next(vcf_reader)
#r.genotype("GTEX-1117F")["GT"]
#s = r.samples[0]

example="/gpfs/data/im-lab/nas40t2/abarbeira/data/test/example-4.0.vcf"
vcf_reader = vcf.Reader(filename=example)
r = next(vcf_reader)
from IPython import embed; embed(); exit()