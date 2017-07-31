# `assembled-genomes/`
Assembled genomes. Two sub-folders: `illumina-genomes/` and `pacbio-genomes/`,
i.e. genomes assembled from Illumina sequencing data and PacBio sequencing data.

See below for more information about the different raw samples that went into Illumina and PacBio sequencing.

## `metagenomes/`
Contains three assembly files and the raw reads used to create those assemblies.

### Assembly files:
* `hiseq_miseq_hyb1.contig-250.fa.gz`:       
  idba_ud co-assembly of hiseq and miseq data in the illumina_4moleculo folder; maxk=250
* `moleculo_asmMeta.all.fasta.gz`:           
  celera assemby of all moleculo reads; includes contigs (ctg), "degenerates" (deg), and singletons (>1000XXX) that didn't assemble
* `pacbio_asm.77771.fasta.gz`:               
  HGAP3 assembly of pacbio data; polished using only the high quality p4c2 data

### Sequence read folders:

Located within `metagenomes/sequence-reads/`. 

Broadly, there are two types of reads: 
long reads (Moleculo, aka `Illumina TruSeq` or PacBio sequencing) and short reads (Illumina sequencing). 
Moleculo and PacBio platforms were run on different samples, 
but a corresponding Illumina run was run on the same sample.


* DNA extracted from 10 aggregates:

  * `moleculo/`:  
        2 libraries sequenced across 2 Hiseq lanes and a Miseq run
  
  * `illumina_4moleculo/`:  
        same batch of DNA as for moleculo library; nextera library prep; 1 full HiSeq lane and 1 MiSeq run
        
        *need to look at this folder more*
        

* DNA extracted from single aggregates:

  * `pacbio/`:  
    DNA extracted from single aggregates; one library prepped from single aggregate (berry 9), another from a mixed pool; most sequence data came from "berry 9" a single aggregate library; 42 smrt cells total - mix of p4c2 and p5c3 chemistries; polishing done w p4c2 only
  
  * `illumina_4pacbio/`:  
    Nextera library from berry 9 single aggregate; barcoded portion of a miseq run. Duplicated in `single-berry-metagenomes/miseq2-renamed/`

# `single-berry-metagenomes/`

DNA extracted from individual berries and sequenced on the Illumina Miseq (accurate short-read).

Samples are numbered Lizzy 1 - Lizzy 10, but only a handful were sequenced. 

Samples were sequenced on two separate miseq runs. Some samples (Lizzy 2 and Lizzy 5) were sequenced twice to increase coverage, found in the `combined-runs/` folder.  Single run samples are found in either `miseq1` folder (Lizzy 2, Lizzy 3, and Lizzy 5) or `miseq2` folder (Lizzy 2, Lizzy 5, Lizzy 9).

* `combined-runs/` 
  Reads (not assembled?) from two berries: Lizzy 2 and Lizzy 5.
  Filenames: Lizzy2-allreads.fastq  Lizzy5-allreads.fastq
  
* `miseq1/` 
  Filenames: 
  DLNT_101_Lizzy2.fastq  DLNT_101_Lizzy3.fastq  DLNT_101_Lizzy5.fastq

* `miseq2-renamed/`
  Filenames: 
  Lizzy2_run2.fastq  Lizzy5_run2.fastq  Lizzy9_run2.fastq
