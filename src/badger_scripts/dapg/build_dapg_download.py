__author__ = "alvaro barbeira"

t = []
with open("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/tissues.txt") as f:
    for line in f:
        t.append(line.strip())


with open("/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/v8/misc/download_dapg_sqtl.sh", "w") as f:
    f.write("#!/bin/bash\n")
    f.write("\n")
    f.write('[ -d data/dapg/sqtl ] || mkdir -p data/dapg/sqtl\n')
    f.write("cd data/dapg/sqtl\n")
    for tissue in t:
        l = "curl https://storage.googleapis.com/gtex-gwas-share/dapg/sqtl/{0}.tar.gz -o {0}.tar.gz\n".format(tissue)
        f.write(l)
    f.write("\n")
    f.write("cd ../../..\n")

with open("/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/v8/misc/download_dapg_parsed_sqtl.sh", "w") as f:
    f.write("#!/bin/bash\n")
    f.write("\n")
    f.write('[ -d data/dapg_parsed/sqtl ] || mkdir -p data/dapg_parsed/sqtl\n')
    f.write("cd data/dapg_parsed/sqtl\n")
    for tissue in t:
        l = "curl https://storage.googleapis.com/gtex-gwas-share/dapg_parsed/sqtl/cluster_correlations/{0}.cluster_correlations.txt.gz -o {0}.cluster_correlations.txt.gz\n".format(tissue)
        f.write(l)
        l = "curl https://storage.googleapis.com/gtex-gwas-share/dapg_parsed/sqtl/clusters/{0}.clusters.txt.gz -o {0}.clusters.txt.gz\n".format(tissue)
        f.write(l)
        l = "curl https://storage.googleapis.com/gtex-gwas-share/dapg_parsed/sqtl/model_summary/{0}.model_summary.txt.gz -o {0}.model_summary.txt.gz\n".format(tissue)
        f.write(l)
        l = "curl https://storage.googleapis.com/gtex-gwas-share/dapg_parsed/sqtl/models/{0}.models.txt.gz -o {0}.models.txt.gz\n".format(tissue)
        f.write(l)
        l = "curl https://storage.googleapis.com/gtex-gwas-share/dapg_parsed/sqtl/models_variants/{0}.models_variants.txt.gz -o {0}.models_variants.txt.gz\n".format(tissue)
        f.write(l)
        l = "curl https://storage.googleapis.com/gtex-gwas-share/dapg_parsed/sqtl/variants_pip/{0}.variants_pip.txt.gz -o {0}.variants_pip.txt.gz\n".format(tissue)
        f.write(l)

    f.write("\n")

    f.write("cd ../../..\n")