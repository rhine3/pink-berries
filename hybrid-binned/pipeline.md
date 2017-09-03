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
$ grep -A1 "_1$" "a1_oceanocaulis.interleaved.fasta" | grep -v "^--$" >  ~/binned-data/deinterleaved/$FILE-deinterleaved/a1_oceanocaulis-reads1.fasta
$ grep -A1 "_2$" "a1_oceanocaulis.interleaved.fasta" | grep -v "^--$" >  ~/binned-data/deinterleaved/$FILE-deinterleaved/a1_oceanocaulis-reads2.fasta
```

## Bin moleculo long reads

## MetaSPAdes

## Unicycler

# A different binning strategy?

