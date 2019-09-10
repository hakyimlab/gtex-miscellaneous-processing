# torus

These runs depend on `torus`, available at [DAP](https://github.com/xqwen/dap) repository.


There is support for three different processes:

- `torus_eqtl.yaml`: get variant priors on eQTL
- `torus_sqtl.yaml`: get variant priors on sQTL
- `torus_sqtl.yaml`: get variant priors on GWAS
- `torus.jinja`: the job template for all runs


`pack_torus.sh` is meant to be submitted into the queue and will build an archive of torus results (it takes too long to finish)