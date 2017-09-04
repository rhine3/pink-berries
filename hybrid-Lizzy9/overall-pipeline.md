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

Direct output to `/home/rhine3/hybrid-assemblies/spades`

```
#PBS -l nodes=1:ppn=12
# specify the time you expect the job to run hh:mm:ss
#PBS -l walltime=06:00:00
#PBS -l mem=64G
# output and error files
#PBS -o myout.o$PBS_JOBID
#PBS -e myout.e$PBS_JOBID

# load paths
source ~/.bashrc

# move to current working directory
cd $PBS_O_WORKDIR

spades.py -1 /home/rhine3/hybrid-assemblies/lizzy9-data/lizzy9-reads1.fastq -2 /home/rhine3/hybrid-assemblies/lizzy9-data/lizzy9-reads2.fastq --pacbio /home/rhine3/hybrid-assemblies/lizzy9-data/lizzy9-pacbio.fastq -o /home/rhine3/hybrid-assemblies/spades

```

Save and run this from within a subdirectory, `spades/qsub`, so that the submit, output, and error files are collected in the same place:

```
cd ~/hybrid-assemblies/spades/qsub
qsub spades-submit.sh
```

Monitor:
`watch --interval=0.5 qstat 2935896`


#### Output
SPAdes produced output in `/home/rhine3/hybrid-assemblies/spades`. 

The single error is stored in `qsub/myout.e2935896.braid.cnsi.ucsb.edu`; the very long output is stored in `qsub/myout.e2935896.braid.cnsi.ucsb.edu`

Contigs/scaffolds within each file are named with the format `>NODE_x_length_y_cov_z`, where `x` is the number of the contig, `y` is the length of the sequence in nucleotides, and `z` is the k-mer coverage (the number of contigs that map to that contig) for the largest k value.

Subdirectories include `K21`, `K33`, `K55`, `K77`, `K99`, and `K127`. These are the results of assemblies conducted on different k-mer sizes. Will have to examine each of these to determine the complexity of the connections (# of nodes and edges) and the number of dead ends. Can use Velvet for this.
