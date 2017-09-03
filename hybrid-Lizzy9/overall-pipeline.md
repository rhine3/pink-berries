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
#PBS -l walltime=24:00:00
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
`watch --interval=0.5 qstat 2935893.braid.cnsi.ucsb.edu`

Got mail:
```
$ cat /var/spool/mail/rhine3

PBS Job Id: 2935893.braid.cnsi.ucsb.edu
Job Name:   spades-submit.sh
Exec host:  node58/23+node58/22+node58/21+node58/20+node58/19+node58/18+node58/17+node58/16+node58/15+node58/14+node58/13+node58/12
Aborted by PBS Server
Job exceeded some resource limit (walltime, mem, etc.). Job was aborted
See Administrator for help

```

The output file:
`=>> PBS: job killed: walltime 81 exceeded limit 60`

Try 00:01:30: `2935894.braid.cnsi.ucsb.edu` - still killed

Try 00:24:00: `2935895.braid.cnsi.ucsb.edu`

Duh, I was submitting in minutes instead of hours

Try 6:00:00
