__author__ = "alvaro barbeira"
import os
import re
import gzip


def get_snps(input_folder, output_file):
    files = [x for x in sorted(os.listdir(input_folder)) if "txt.gz" in x]
    files = [os.path.join(input_folder, x) for x in files]

    with gzip.open(output_file, "w") as o:
        o.write("chr\trsid\tposition\tref_allele\teff_allele\tAF\n".encode())
        for file in files:
            print(os.path.split(file)[1])
            with gzip.open(file) as i:
                for l in i:
                    comps = l.decode().strip(). split()
                    ol = "\t".join(comps[0:6]) + "\n"
                    o.write(ol.encode())


print("dosage")
get_snps("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage",
         "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage_snps.txt.gz")

print("dosage by variant")
get_snps("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage_gtex_variant",
         "/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38/dosage_gtex_variant_snps.txt.gz")

print("done")