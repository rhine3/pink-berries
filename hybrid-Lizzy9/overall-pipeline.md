Trying to replicate and improve on initial assemblies by Matt Melissa & Michael Pearce (see respective pipeline.md files)

## SPAdes assembly on Lizzy9 PacBio data

#### Deinterleave paired-end file:
`/home/rhine3/data/metagenomes/sequence_reads/illumina_4pacbio/Lizzy9.fastq`

#### Use corrected pacbio data:
`/home/rhine3/data/metagenomes/sequence_reads/pacbio/corrected.fastq`

```
#PBS -l nodes=1:ppn=12
# specify the time you expect the job to run hh:mm:ss
#PBS -l walltime=24:00:00
#PBS -l mem=64G
# output and error files
#PBS -o myout.o$PBS_JOBID
#PBS -e myout.e$PBS_JOBID

# load paths
source ~/.bashrc

# move to current working directory
cd $PBS_O_WORKDIR

spades.py -1 /home/rhine3/data/metagenomes/sequence_reads/illumina_4moleculo/Pb2_MiseqNextera/Pb2_MiseqNextera_R1.fastq -2 /home/rhine3/data/metagenomes/sequence_reads/illumina_4moleculo/Pb2_MiseqNextera/Pb2_MiseqNextera_R2.fastq -o assembled_Pb2_MiseqNextera
```
