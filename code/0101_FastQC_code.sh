#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 01:00:00
#SBATCH -J 0101_FastQC_code.sh
#SBATCH --mail-type=ALL
#SBATCH --mail-user corinne.olivero.6280@student.uu.se

# Load modules
module load bioinfo-tools
module load FastQC

# variables
INPUT="/home/cool6280/project_genome_analysis/raw_data/RNA_raw_data/*.fastq.gz"
OUTPUT="/home/cool6280/project_genome_analysis/Genome_analysis/analyses/RNA_analyses/01_FastQC"

# running FastQC
fastqc -t 4 -o $OUTPUT -d $OUTPUT $INPUT
