
## Unicycler Assembly
### By Michael Pearce

See [the documentation](https://github.com/rrwick/Unicycler#advanced-options)

Unicycler requires paired end reads to be in separate files, e.g. reads1.fastq and reads2.fastq. Interleaved reads can be separated using the following code in the command line:

```
grep -A3 "/1$" "reads.fastq" | grep -v "^--$" > reads1.fastq
grep -A3 "/2$" "reads.fastq" | grep -v "^--$" > reads2.fastq
```
The `-A3 "/1$"` means to keep the three lines (`-A3`) after the line ending with `/1`. The `-v "^--$"` part cuts off an extra `--` (check that this is necessary for your file).

Here is a script to run unicycler with the default options:
```
#!/bin/bash
# specify number of nodes and cores per node
#PBS -l nodes=1:ppn=12
# specify the time you expect the job to run hh:mm:ss
#PBS -l walltime=24:00:00
#PBS -l mem=48G
# output and error files
#PBS -o cluster-output/myout.o$PBS_JOBID
#PBS -e cluster-output/myout.e$PBS_JOBID

#set bash
source ~/.bashrc

#change directory
cd $PBS_O_WORKDIR

unicycler -1 /home/qbio12/unicycler_assembly/Lizzy9-deinterleaved-1.fastq -2 /home/qbio12/unicycler_assembly/Lizzy9-deinterleaved-2.fastq -l /home/qbio12/unicycler_assembly/pacbio-corrected.fastq -o pacbio-lizzy9-assembly
```
The input files following `-1` and `-2` are read1 and read2 of the pair-ends. The input `-l` is the long reads file and `-o` is the output directory. 

There used to be an option to manually control the filtering depth below which contigs are thrown out, but the option is no longer present. See `unicycler --help_all` for the list of options.

**Results**
* The assembly results for the pacbio + illumina_4pacbio reads of Lizzy9 can be found in the folder:
`/home/qbiodata/pinkberries/unicycler_assembly`
In this folder there is:
    * the files used: `Lizzy9-deinterleaved-1.fastq`, `Lizzy9-deinterleaved-2.fastq`, and `pacbio-corrected.fastq`
    * the assembly results in `pacbio-lizzy9-assembly`
