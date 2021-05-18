# hipergator-targets

<!-- badges: start -->

<!-- badges: end -->

This is a minimal example of a `targets` workflow that can run on HiperGator HPC using the `clustermq` backend for paralellization.
To use, SSH into HiperGator and navigate to your `blue` or `orange` directory and clone this repository by running.

    git clone https://github.com/BrunaLab/hipergator-targets.git

Edit `submit_pipeline.sbatch` in a text editor to include your email address and any other SLURM settings you wish.

Make sure all necessary packages are installed by running `Rscript packages.R` without getting any errors.
(Hopefully I can eventually figure out how to get `renv` working on HiperGator to skip this step)

Then, start the workflow by running `sbatch submit_pipeline.sbatch`.
This will start a job on HiperGator that will in turn spawn other jobs using the `clustermq` package and the `slurm_clustermq.tmpl` file.

You may also want to test that this workflow runs locally on your computer.
You can clone this repository locally and run `targets::tar_make()` in the console to run it.
See documentation for the `targets` package for more information.
