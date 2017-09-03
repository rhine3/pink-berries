# SPAdes pipeline
### by Matthew Melissa

## Getting started: test assembly

As a first step, you can test out spades on their toy data set. To do so, create the following script titled submit_spades_test.sh in your home directory:

```
#!/bin/bash
# specify number of nodes and cores per node
#PBS -l nodes=1:ppn=1
# specify the time you expect the job to run hh:mm:ss
#PBS -l walltime=02:00:00
#PBS -l mem=8G
# output and error files
#PBS -o myout.o$PBS_JOBID
#PBS -e myout.e$PBS_JOBID

# load paths
source ~/.bashrc

# move to current working directory
cd $PBS_O_WORKDIR


spades.py --test

```
and then run it by entering qsub submit_spades_test.sh into the command line. It should take a few minutes to run, you can check the myout file to make sure it runs correctly. The output contents will be located in a folder (in your home directory) called spades_test.

# Attempt to assemble berry reads

Now let's try assembling some actual sequence data. To start, we can look at the Illumina reads from the Pacbio sample. I've titled the following script submit_spades_paired.sh:

```
# specify number of nodes and cores per node
#PBS -l nodes=1:ppn=1
# specify the time you expect the job to run hh:mm:ss
#PBS -l walltime=24:00:00
#PBS -l mem=12G
# output and error files
#PBS -o myout.o$PBS_JOBID
#PBS -e myout.e$PBS_JOBID

# load paths
source ~/.bashrc

# move to current working directory
cd $PBS_O_WORKDIR

spades.py --12 /home/rhine3/data/metagenomes/sequence_reads/illumina_4pacbio/Lizzy9.fastq -o assembled_illumina_4pacbio

```
which can be run as qsub submit_spades_paired.sh. The command spades.py has two options: the first one specifies the input, file with --12 denoting that the files contains interleaved paired-end reads (alternating lines of forward and the corresponding reverse reads). Note that we've given a .fastq file as input--spades will not accept a .fasta file because it needs information about the quality and does an error correction step. The output directory is specified with the -o option.

If the forward and reverse reads are split up the script would be

```
#PBS -l nodes=1:ppn=1
# specify the time you expect the job to run hh:mm:ss
#PBS -l walltime=24:00:00
#PBS -l mem=8G
# output and error files
#PBS -o myout.o$PBS_JOBID
#PBS -e myout.e$PBS_JOBID

# load paths
source ~/.bashrc

# move to current working directory
cd $PBS_O_WORKDIR

spades.py -1 /home/rhine3/data/metagenomes/sequence_reads/illumina_4moleculo/Pb2_MiseqNextera/Pb2_MiseqNextera_R1.fastq -2 /home/rhine3/data/metagenomes/sequence_reads/illumina_4moleculo/Pb2_MiseqNextera/Pb2_MiseqNextera_R2.fastq -o assembled_Pb2_MiseqNextera

```
where here the -1 option specifies the .fastq file containing forward reads and the -2 option specifies the .fastq file containing reverse reads. 

Regarding memory and time requirements: spades gives examples using 16 threads and 8GB memory--I think each thread requires roughly 0.5GB for good performance. I'm working on testing out how much memory we can request without our queue being delayed.

To run quast on the finished assembly (without a reference genome), run the following line on the terminal:
```
quast.py /home/qbio18/assembled_illumina_4pacbio_10G/contigs.fasta
```

* Completed a hybrid assembly using:
    * Long reads: /home/rhine3/data/metagenomes/sequence_reads/pacbio/corrected.fastq
    * Short reads: /home/rhine3/data/metagenomes/sequence_reads/illumina_4pacbio/Lizzy9.fastq
    * Results directory: /home/qbio18/assembled_hybrid_12ppn
 * Attempted (unsucessfully) a hybrid assembly of Pacbio reads and all Illumina/Moleculo reads. Requested 1 node, 12 ppn, 64 GB total. Got an error message saying that it ran out of memory (194GB needed).
     * Results directory: /home/qbio18/assembled_hybrid_moleculo
