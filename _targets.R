## set options
nodename <- Sys.info()["nodename"]
if (grepl("ufhpc", nodename)) {
  print("I know I am on the HiperGator!")
  options(clustermq.scheduler = "slurm", clustermq.template = "slurm_clustermq.tmpl")
} else {
  print("this is local")
  options(clustermq.scheduler="multiprocess")
}


## Load your packages, e.g. library(targets).
source("./packages.R")
lapply(list.files("R", full.names = TRUE), source)

tar_option_set()

## tar_plan supports drake-style targets and also tar_target()
tar_plan(
  many_vects = make_vects(),
  means = map(many_vects, ~mean(.x)),
  means_mean = mean(unlist(means)),
  
  dat = gamSim(1, n = 25000, dist = "normal", scale = 20),
  model = fit_bam(dat)
  
)