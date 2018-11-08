__author__ = "alvaro barbeira"
import pandas
import numpy


GTEX_METADATA="/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/gtex_metadata.csv"
OUTPUT_YAML_GTEX="/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/src/gtex/badger_scripts/susier/gtex_info.yaml"

gtex = pandas.read_csv(GTEX_METADATA, usecols=["tissue", "v8_all"]).rename(columns={"v8_all":"gtex_sample_size"})

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
        l = "  {}:\n    {{ gtex_sample_size:{:d} }}\n".format(t.tissue, int(t.gtex_sample_size))
        f.write(l)

#from IPython import embed; embed(); exit()