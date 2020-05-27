# PrediXcan sample data

This package contains sample data to illustrate the applications of individual-level PrediXcan.
We include two prediction models based on: 
- Elastic Net algorithm, restricted to HapMap CEU snps. This a general-purpose model usable in most situations.
- MASHR method with fine-mapping from DAP-G. This model is more powerful but depends on variants that might be missing from a typical GWAS.

# contents
```
data
#Thousand genomes genotype from hg37, ~2504 individuals
├── 1000G_hg37
│   ├── ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
│   └── random_pheno_1000G_hg37.txt
#Thousand genomes genotype from hg37 in bgen format (same as above but a few variants got dropped)
├── 1000G_hg37_bgen
│   ├── chr22.bgen
│   └── chr22.bgen.metadata
#Thousand genomes genotype from hg37 inPrediXcan `dosage` format
├── 1000G_hg37_dosage
│   ├── chr22.txt.gz
│   └── samples.txt
#Thousand genomes genotype from hg38, ~2550 individuals
├── 1000G_hg38
│   ├── ALL.chr22.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz
│   └── random_pheno_1000G_hg38.txt
#sample bash commands I used to run PrediXcan
├── examples
│   ├── bgen_1000G_hg37_en.sh
│   ├── bgen_1000G_hg37_en_test.sh
│   ├── vcf_1000G_hg37_en_a.sh
│   ├── vcf_1000G_hg37_en_b.sh
│   ├── vcf_1000G_hg37_en_old_predixcan.sh
│   ├── vcf_1000G_hg37_mashr.sh
│   ├── vcf_1000G_hg38_en.sh
│   └── vcf_1000G_hg38_mashr.sh
# Definition of variants included in gtex models
├── gtex_v8_eur_filtered_maf0.01_monoallelic_variants.txt.gz
# Liftover chain to convert from hg19 to hg38
├── hg19ToHg38.over.chain.gz
└── models
# Elastic Net prediction model for gene expression on GTEx data
    ├── gtex_v8_en
    │   └── en_Whole_Blood.db
# Mashr prediction model for gene expression on GTEx data
    └── gtex_v8_mashr
        └── mashr_Whole_Blood.db
``` 

# Data construction

This package uses data releases from Thousand Genomes.
We document here how we generated it.
We accessed both an hg37-based released and an hg38-based release in the original vcf format.

```bash
mkdir -p data/1000G_hg37
cd data/1000G_hg37
for PBS_ARRAYID in {1..22}
do
    wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr${PBS_ARRAYID}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
    wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr${PBS_ARRAYID}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz.tbi
done
cd ../..
```

```bash
mkdir -p data/1000G_hg38
cd data/1000G_hg38
for PBS_ARRAYID in {1..22}
do
    wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000_genomes_project/release/20190312_biallelic_SNV_and_INDEL/ALL.chr${PBS_ARRAYID}.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz
    wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000_genomes_project/release/20190312_biallelic_SNV_and_INDEL/ALL.chr${PBS_ARRAYID}.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz.tbi
done
```

We also converted the vcfs to bgen using the following:

```bash
OF=data/1000G_hg37_bgen
[ -d  $OF ] || mkdir -p $OF

for PBS_ARRAYID in {1..22}
do
    plink2 \
    --vcf data/1000G_hg37/ALL.chr{PBS_ARRAYID}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
    --export bgen-1.3 ref-first \
    --out $OF/chr{PBS_ARRAYID} \
    --threads 1
done
```



