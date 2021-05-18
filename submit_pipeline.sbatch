#!/bin/bash
#SBATCH --job-name=cmq-toplevel   # Job name
#SBATCH --mail-type=ALL               # Mail events (NONE, BEGIN, END, FAIL, AL$
#SBATCH --mail-user=ericscott@ufl.edu   # Where to send mail
#SBATCH --ntasks=1                 # Number of MPI ranks
#SBATCH --cpus-per-task=1            # Number of cores per MPI rank
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=24:00:00       #Time limit hrs:min:sec
#SBATCH --output logs/pipeline%j.out
#SBATCH --error logs/pipeline%j.err

#This is a generic R submission script
module load R
Rscript pipeline.R
