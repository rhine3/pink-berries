#!/bin/bash
# specify number of nodes and cores per node
#PBS -l nodes=1:ppn=1
# specify the time you expect the job to run hh:mm:ss
#PBS -l walltime=2:00:00
# output and error files
#PBS -o myout.o$PBS_JOBID
#PBS -e myout.e$PBS_JOBID

source ~/.bashrc

cd $PBS_O_WORKDIR

bwa mem -t 8 /home/
