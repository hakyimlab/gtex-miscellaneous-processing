__author__ = "alvaro barbeira"
import pandas
import numpy
import datetime

INPUT="/scratch/abarbeira3/v8_process/enloc/sqtl/enloc_sqtl_tissue_spec.txt"
OUTPUT_YAML_SPEC="/gpfs/data/im-lab/nas40t2/abarbeira/software/genomic_tools/gtex/src/badger_scripts/enloc/enloc_sqtl_tissue_spec.yaml"

d = pandas.read_table(INPUT)


with open(OUTPUT_YAML_SPEC, "w") as f:
    f.write("---\n")
    f.write("enloc_sqtl_tissue_info:\n")
    for t in d.itertuples():
        _t = int(numpy.ceil(t.walltime/3600.0))+6
        _m = int(numpy.ceil(t.memory/1000.0))+3
        l = '  {}:\n    {{ walltime: "{}:00:00", memory: "{}gb" }}\n'.format(t.tissue, _t, _m)
        f.write(l)
