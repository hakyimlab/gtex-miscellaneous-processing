import pandas
import gzip

TG="/scratch/abarbeira3/data/1000G_hg37/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz"
hg37_ids = []
with gzip.open(TG) as tg:
    for line in tg:
        line = line.decode()
        if "#CHROM" in line:
            hg37_ids = line.strip().split()[9:]
            break


TGS="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/1000G/20140502_all_samples.ped"

samples = pandas.read_table(TGS)
samples = samples.rename(columns={"Paternal ID":"paternal_id", "Maternal ID":"maternal_id", "Individual ID":"individual_id", "Family ID":"family_id"})
samples = samples[samples.Population.isin({"CEU", "TSI", "FIN", "GBR", "IBS"})]
samples = samples[(samples.paternal_id == "0") & (samples.maternal_id == "0")]
samples = samples[samples["Other Comments"] != 'relationships are uncertain']

i = samples.individual_id
i = i[i.isin(hg37_ids)]
i.to_csv("/gpfs/data/im-lab/nas40t2/abarbeira/data/1000G/selected_hg37_eur_id.txt", header=False, index=False)