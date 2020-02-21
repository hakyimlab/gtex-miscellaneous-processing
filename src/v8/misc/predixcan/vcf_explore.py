import vcf
import io
import gzip
gtex = "/gpfs/data/gtex-group/v8/59348/gtex/exchange/GTEx_phs000424/exchange/analysis_releases/GTEx_Analysis_2017-06-05_v8/genotypes/WGS/variant_calls/GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.SHAPEIT2_phased.vcf.gz"
vcf_reader = vcf.Reader(io.TextIOWrapper(gzip.open(gtex)), "r")
r.genotype("GTEX-1117F")["GT"]
from IPython import embed; embed(); exit()