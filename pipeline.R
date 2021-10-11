## Install necessary packages
renv::restore()
## Run the pipeline
targets::tar_make_future(workers = 2L)
print("Completed OK")