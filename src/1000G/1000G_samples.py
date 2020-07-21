import gzip

def get_samples(vcf):
  samples = []
  with gzip.open(vcf) as vcf:
    for line in vcf:
      l = line.decode()
      if "#CHROM" in l:
        samples = l.strip().split()[9:]
        break
  return samples

def write_samples(samples, file):
  with open(file, "w") as f:
    for s in samples:
      l = "{s}\t{s}\n".format(s=s)
      f.write(l)

samples = get_samples("/scratch/abarbeira3/data/1000G_hg37/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz")
samples = write_samples(samples, "/scratch/abarbeira3/data/1000G_hg37_dosage/samples.txt")

samples = get_samples("/scratch/abarbeira3/data/1000G_hg38/ALL.chr22.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz")
samples = write_samples(samples, "/scratch/abarbeira3/data/1000G_hg38_dosage/samples.txt")