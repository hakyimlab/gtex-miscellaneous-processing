import pandas


for i in range(1,23):
    print(i)
    p = "/scratch/abarbeira3/data/1000G_EUR_MT/chr{}_annotation.txt.gz".format(i)
    p = pandas.read_table(p)
    p.to_csv("/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data_formatting/1000G_hg38_EUR_MT/metadata.txt.gz",
             index=False, sep="\t", compression="gzip", mode="w" if i == 1 else "a", header=i == 1, na_rep="NA")
