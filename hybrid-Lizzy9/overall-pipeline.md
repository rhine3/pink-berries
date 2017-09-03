Trying to replicate and improve on initial assemblies by Matt Melissa (attempted assembly on SPAdes) & Michael Pearce (assembly on Unicycler)--see respective pipeline.md files.

## SPAdes assembly on Lizzy9 PacBio data
Copying all data into `/home/rhine3/hybrid-assemblies/lizzy9-data/`

After the next two steps the data will be in these filenames within the folder:
```
lizzy9-pacbio.fastq
lizzy9-reads1.fastq
lizzy9-reads2.fastq
```

#### Deinterleave paired-end file:
`/home/rhine3/data/metagenomes/sequence_reads/illumina_4pacbio/Lizzy9.fastq`

```
grep -A3 "/1$" "/home/rhine3/data/metagenomes/sequence_reads/illumina_4pacbio/Lizzy9.fastq" | grep -v "^--$" > /home/rhine3/hybrid-assemblies/lizzy9-data/lizzy9-reads1.fastq
grep -A3 "/2$" "/home/rhine3/data/metagenomes/sequence_reads/illumina_4pacbio/Lizzy9.fastq" | grep -v "^--$" > /home/rhine3/hybrid-assemblies/lizzy9-data/lizzy9-reads2.fastq
```

#### Use corrected pacbio data:
`cp /home/rhine3/data/metagenomes/sequence_reads/pacbio/corrected.fastq 
/home/rhine3/hybrid-assemblies/lizzy9-data/lizzy9-pacbio.fastq`


#### Qsub file:
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

spades.py -1 /home/rhine3/hybrid-assemblies/lizzy9-data/lizzy9-reads1.fastq -2 /home/rhine3/hybrid-assemblies/lizzy9-data/lizzy9-reads2.fastq --pacbio /home/rhine3/hybrid-assemblies/lizzy9-data/lizzy9-pacbio.fastq -o assembled_Pb2_MiseqNextera
```
