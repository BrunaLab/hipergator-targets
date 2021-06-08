## Figures out if this is being run locally or on HiperGator:
nodename <- Sys.info()["nodename"]
if (grepl("ufhpc", nodename)) {
  print("This is running on HiperGator!")
  options(clustermq.scheduler = "slurm", clustermq.template = "slurm_clustermq.tmpl")
} else {
  print("This is running locally!")
  options(clustermq.scheduler="multiprocess")
}


## Load your packages, e.g. library(targets).
source("./packages.R")
lapply(list.files("R", full.names = TRUE), source)

## Set options
options(tidyverse.quiet = TRUE)
if (grepl("ufhpc", nodename)) {
  tar_option_set(resources = list(num_cores = 1L)) # number of cores *per worker*
} else {
  tar_option_set()
}

## tar_plan supports drake-style targets and also tar_target()
tar_plan(
  many_vects = make_vects(),
  means = map(many_vects, ~mean(.x)),
  sds = map(many_vects, ~sd(.x)),
  # these targets should be able to run in parallel:
  means_mean = mean(unlist(means)),
  sd_means = mean(unlist(sds))
)