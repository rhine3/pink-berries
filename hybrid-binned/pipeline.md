# Pipeline for binned reads

## Short reads from Lizzy's initial binning strategy 
Aside from the purple sulfur bacteria and sulfur-reducing bacteria, there are eight high-abundance OTUs that Lizzy binned:

```
$ ls /data/metagenomes/sequence_reads/illumina_4moleculo/quality-trimmed-reads/reads-by-genome/

a1_oceanocaulis.interleaved.fasta
a2_rhodobacterales.interleaved.fasta
a3_micavibrio.interleaved.fasta
b1_flavo.interleaved.fasta
b2_owen.interleaved.fasta
b3_bact.interleaved.fasta
b4_cyt1.interleaved.fasta
b5_cyt2.interleaved.fasta
```
# Need to look more into how these were binned

### Deinterleave reads
These are paired-end reads. Check out the format:
```
$ head -8 a1_oceanocaulis.interleaved.fasta

>M01533:9:000000000-A20UG:1:1111:13763:22044_1
TGGTCTCAGGATTGAATTCAGAGCCCACCGGGTTTTGCATCCAGCCATTGGCGATCAGAATCCACAGCGCTGACAGGTTGGTGCCCAGCGCCATCAGCCAGGTGGCGGCCAGGTGTCCGCGCTTGCTCATCCGGTCCCAGCCAAAGAAGAACAGGCCCACCAGCGTGGCTTCCAGGAAGAAGGCCATCAGGCCCTCGATCGCCAGCGGCGCCCCGAACACATCTCCGAGCCCACGAGACCGAGGCTGATC
>M01533:9:000000000-A20UG:1:1111:13763:22044_2
GCAACTGGCTGACCATCCGGCTGGGTTGGTATCTGATGGTCGGGCTGGGTGGGGGGCCTCGTCGGCGTCTCGCTGGTCCTCCCGCTCGCGGGCCTGCTGGTCTTTTGCTCGTCTGTGTTGTGCACGCGGGGGTGCATGCTCGTCCCGCCGTGGATGGCGCGGGGGGAGAGGGTGGCCGACAGGCCTCGTCGCGGCGCGCACTCCTCGACGCCGGACTCGCCTATGGCTGTGAGATGTGTAGCGGTCGGTC
>M01533:9:000000000-A20UG:1:2101:24271:11419_1
GCCCCACCTGGCACGCGTTGGGGGCGTAGCCGGCCTCCACCGCGTCCCGCGTGGTGGTCGCGGGACGTGGCCAGGTCTGGGCCCTCACCCTGGGCCTGCCCCACAACCTCACAAAGGCTCGATGGGTCAGGGTGCTCCGTCTTGGTCTCGTCTGCCTTCGCCCCGGCGCAGGCAGACGAGACCAAGACGGAGCACCCTGACCCATCGAGCCTTTGTGAGGTTGTGGGGCAGGCCCAGGGTGAGCTGTCTC
>M01533:9:000000000-A20UG:1:2101:24271:11419_2
CTCACCCTGGGCCTGCCCCACAACCTCACAAAGGCTCGATGGGTCAGGGTGCTCCGTCTTGGTCTCGTCTGCCTGCGCCGGGGCGAAGGCAGACGAGACCAAGACGGGGCACCCTGACCCATCGAGCCTTTGTGGGGGTGTGGGGGAGGCCCAGGG
```

Copied to a new directory, `~/binned-data/`. To deinterleave as a group:

```
$ cd ~/binned-data/
$ mkdir deinterleaved
$ for FILE in *; do 
mkdir ~/binned-data/deinterleaved/$FILE-deinterleaved;
grep -A1 "_1$" "$FILE" | grep -v "^--$" >  ~/binned-data/deinterleaved/$FILE-deinterleaved/$FILE-reads1.fasta; 
grep -A1 "_2$" "$FILE" | grep -v "^--$" >  ~/binned-data/deinterleaved/$FILE-deinterleaved/$FILE-reads2.fasta; 
done
```

(Just do one first to make sure the deinterleaving works well with the rest of the pipeline)
```
$ grep -A1 "_1$" "a1_oceanocaulis.interleaved.fasta" | grep -v "^--$" >  ~/binned-data/deinterleaved/a1_oceanocaulis-reads1.fasta
$ grep -A1 "_2$" "a1_oceanocaulis.interleaved.fasta" | grep -v "^--$" >  ~/binned-data/deinterleaved/a1_oceanocaulis-reads2.fasta
```

## SPAdes without binning long reads

```
#PBS -l nodes=1:ppn=1
# specify the time you expect the job to run hh:mm:ss
#PBS -l walltime=00:20:00
#PBS -l mem=8G
# output and error files
#PBS -o myout.o$PBS_JOBID
#PBS -e myout.e$PBS_JOBID

# load paths
source ~/.bashrc

# move to data directory
cd /home/rhine3/binned-data/deinterleaved/

spades.py -1 a1_oceanocaulis-reads2.fasta -2 a1_oceanocaulis-reads2.fasta --pacbio /home/rhine3/data/metagenomes/sequence_reads/moleculo/pb2.moleculo.all.fasta -o ~/binned-hybrid-results/a1_oceanocaulis/
```
Doesn't work--binned short reads are in .fasta but spades requires .fastq

## Bin moleculo long reads?

## Unicycler

# A different binning strategy?

# Pipeline for binned reads
Bowtie





Align to reference genome: Pacbio - (blastr), Illumina - (bowtie2 v2.2.3 (Langmead & Salzburg 2012))

Pathoscope v1.0 (Francis et al., 2013) used to reassign multiply mapping reads to most likely genome

16SRNA reads classified using RSP training set 9 (Wang et al. 2009), ITS1 sequnces classifeid with custom database (Findley et al. 2013)


Assembled with SPAdes-3.5.0 (Bankevich et al. 2012), Megahit (Li et al., 2015), and Velvet (Zerbino & Birney 2008)

QUASY v2.3 - evaluated assembly quality (Gurevich et al. 2013)

Misassembly: if L and R flanking seq align more than 1kb apart, if overlap between contigs > 1kb, or if flanking seq align on opposite strands

Coverage calculated as total number of aligned bases/genome size  

Longest contigs manually connected into single chromosome based on overlap, polished with Quiver consensus algorithm

To make taxonomic assignment - obtained 16SRNA sequences from RDP that were similar to what they expected the reconstructed genome to be. 
RNAmmer (Lagesen et al., 2007) - predicts 16SRNA sequences in full genomes

Aligned with RDP’s rRNA models (Wang et al., 2007) and Infernal aligner (Nawrocki et al., 2009) 

Used MEGA to create bootstrap consensus tree using neighbor joining (Tamura et al., 2013)

Used NUCmer for genome comparisons and plot generation (Delcher et al., 2012)



