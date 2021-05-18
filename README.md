# hipergator-targets

<!-- badges: start -->

<!-- badges: end -->

This is a minimal example of a [`targets`](https://docs.ropensci.org/targets/) workflow that can run on [HiperGator](https://www.rc.ufl.edu/services/hipergator/) HPC using the [`clustermq`](https://mschubert.github.io/clustermq/) backend for paralellization.
To use, [SSH into HiperGator](https://help.rc.ufl.edu/doc/Getting_Started#Connecting_to_HiPerGator) and navigate to your `blue` or `orange` directory.
Then clone this repository by running:

    git clone https://github.com/BrunaLab/hipergator-targets.git

Edit `submit_pipeline.sbatch` in a text editor to include your email address and any other SLURM settings you wish.

Then, start the workflow by running `sbatch submit_pipeline.sbatch`.
This will start a job on HiperGator that will in turn spawn other jobs using the `clustermq` package and the `slurm_clustermq.tmpl` file.
The project is set up to use [`renv`](https://rstudio.github.io/renv/index.html) to manage a package library so as long as the lockfile is up-to-date, all necessary packages should be installed.

## How it works:

1.  `submit_pipeline.sbatch` tells SLURM to load R and then run `pipeline.R`---that's it. This starts a top-level job running on HiperGator.
2.  `pipeline.R` installs dependencies with `renv::restore()`, then runs the `targets` workflow with `tar_make_clustermq()`.
3.  Using `tar_make_clustermq()` spawns worker jobs on HiperGator using the `slurm_clustermq.tmpl` file as a template for the SLURM submission scripts for each worker.

The parallelization happens at the level of targets.
In this example, a list of numeric vectors is stored as `many_vects`.
Then, independently, means and standard deviations are calculated for each vector in the list.
These two targets (the means and the sd's) should be able to run on separate workers in parallel if things are set up correctly.
Parallelizing code *within* a target (e.g. a function that does parallel computation) will require more setup.

You may also want to test that this workflow runs locally on your computer.
You can clone this repository locally and run `targets::tar_make()` in the console to run it.
See [documentation for the `targets` package](https://books.ropensci.org/targets/) for more information.

## Acknowledgments

Shouts to [\@diazrenata](https://github.com/diazrenata) for taking the time to help me figure this out.
