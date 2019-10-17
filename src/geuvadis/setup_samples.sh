#!/usr/bin/env bash

I=/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur
IS=$I/dosage/samples.txt

O=/gpfs/data/im-lab/nas40t2/abarbeira/projects/gtex_v8/data/geuvadis_eur_hg38
OD=$O/dosage
OS=$OD/samples.txt
OI=$OD/sample_ids.txt
[ -d $O ] || mkdir -p $O

cat $IS | grep -v -E "HG00124|HG00247|NA11993" > $OS
cat $OS | cut -f1 > $OI