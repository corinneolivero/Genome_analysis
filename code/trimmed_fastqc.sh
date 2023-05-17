#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J trimmed_fastqc.sh
#SBATCH --mail-type=ALL
#SBATCH --mail-user corinne.olivero.6280@rackham.uppmax.uu.se

# Load modules
module load bioinfo-tools
module load FastQC

# variables
INPUT="/home/cool6280/project_genome_analysis/raw_data/RNA_trimmed_reads/*.fastq.gz"
OUTPUT="/home/cool6280/project_genome_analysis/Genome_analysis/analyses/RNA_analyses/01_FastQC"

# running FastQC
fastqc -t 4 -o $OUTPUT -d $OUTPUT $INPUT



