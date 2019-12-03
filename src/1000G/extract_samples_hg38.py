import pandas
import gzip

TG="/scratch/abarbeira3/data/1000G/ALL.chr1.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz"
hg38_ids = []
with gzip.open(TG) as tg:
    for line in tg:
        line = line.decode()
        if "#CHROM" in line:
            hg38_ids = line.strip().split()[9:]
            break


TGS="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/1000G/20140502_all_samples.ped"

samples = pandas.read_table(TGS)
samples = samples.rename(columns={"Paternal ID":"paternal_id", "Maternal ID":"maternal_id", "Individual ID":"individual_id", "Family ID":"family_id"})
samples = samples[samples.Population.isin({"CEU", "TSI", "FIN", "GBR", "IBS"})]
samples = samples[(samples.paternal_id == "0") & (samples.maternal_id == "0")]
samples = samples[samples["Other Comments"] != 'relationships are uncertain']

i = samples.individual_id
i = i[i.isin(hg38_ids)]
i.to_csv("selected_hg38_eur_id.txt", header=False, index=False)