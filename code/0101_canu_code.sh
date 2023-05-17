#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 20:00:00
#SBATCH -J 01_canu_test
#SBATCH --mail-type=ALL
#SBATCH --mail-user corinne.olivero.6280@student.uu.se

# Load modules
module load bioinfo-tools
module load canu


# Run canu
canu -p my_DNA_assembly -d /home/cool6280/project_genome_analysis/Genome_analysis/analyses genomeSize=3m useGrid=false maxThreads=4 -pacbio-raw /home/cool6280/project_genome_analysis/raw_data/DNA_raw_data/*


