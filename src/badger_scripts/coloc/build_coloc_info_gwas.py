__author__ = "alvaro barbeira"
import pandas
import numpy

ENLOC_ENRICHMENT="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/enloc_enrichment.txt"
GWAS_METADATA="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/gwas_metadata.txt"
GTEX_METADATA="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/gtex_metadata.csv"
OUTPUT="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/priors_info.txt"
OUTPUT_YAML_GTEX="/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/badger_scripts/gtex_info.yaml"

OUTPUT_YAML="/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/badger_scripts/coloc/coloc_info.yaml"
SWAP = False
#p1 is for tissue
e = pandas.read_table(ENLOC_ENRICHMENT,usecols=["tissue", "trait", "p1", "p2", "p12"])

g = pandas.read_table(GWAS_METADATA, usecols=["Tag", "new_Phenotype", "Sample_Size"]).rename(columns={"Tag":"phenotype", "Sample_Size":"gwas_sample_size"})
gtex = pandas.read_csv(GTEX_METADATA, usecols=["tissue", "v8_all"]).rename(columns={"v8_all":"gtex_sample_size"})
d = e.merge(g, left_on="trait", right_on="new_Phenotype").\
    rename(columns={"Tag":"phenotype", "Sample_Size":"gwas_sample_size"}).\
    merge(gtex, on="tissue")
[["phenotype", "tissue", "p1", "p2", "p12", "gwas_sample_size", "gtex_sample_size"]]
d.to_csv(OUTPUT,index=False, sep="\t")

with open(OUTPUT_YAML, "w") as f:
    f.write("---\n")
    f.write("coloc_info:\n")
    for t in d.itertuples():
        #note that p1 is for tissue in input,
        # but we output the other way
        p1 = t.p1 if not SWAP else t.p2
        p2 = t.p2 if not SWAP else t.p1
        if not numpy.isnan(t.gwas_sample_size):
            #                                                                                                                                                *     *
            l = "  {}_{}:\n    {{ p1: {:.10f}, p2: {:.10f}, p12: {:.10f}, gwas_sample_size: {:d}, gtex_sample_size: {:d} }}\n".format(t.phenotype, t.tissue, p1, p2, t.p12, int(t.gwas_sample_size), int(t.gtex_sample_size))
        else:
            #                                                                                                                        *     *
            l = "  {}_{}:\n    {{ p1: {:.10f}, p2: {:.10f}, p12: {:.10f}, gwas_sample_size: FROM_GWAS, gtex_sample_size: {:d} }}\n".format(t.phenotype, t.tissue, p1, p2, t.p12, int(t.gtex_sample_size))
        f.write(l)

with open(OUTPUT_YAML_GTEX, "w") as f:
    f.write("---\n")
    f.write("gtex_info:\n")
    for t in gtex.itertuples():
        l = "  {}:\n    {{ gtex_sample_size: {:d} }}\n".format(t.tissue, int(t.gtex_sample_size))
        f.write(l)
