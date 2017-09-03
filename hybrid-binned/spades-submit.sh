
#PBS -l nodes=1:ppn=1
# specify the time you expect the job to run hh:mm:ss
#PBS -l walltime=00:20:00
#PBS -l mem=8G
# output and error files
#PBS -o myout.o$PBS_JOBID
#PBS -e myout.e$PBS_JOBID

# load paths
source ~/.bashrc

# move to current working directory
cd /home/rhine3/binned-data/deinterleaved/

spades.py -1 a1_oceanocaulis-reads2.fasta -2 a1_oceanocaulis-reads2.fasta --pacbio /home/rhine3/data/metagenomes/sequence_reads/moleculo/pb2.moleculo.all.fasta -o ~/binned-hybrid-results/a1_oceanocaulis/
