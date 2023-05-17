#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 01:00:00
#SBATCH -J 0101_blastn_synteny.sh
#SBATCH --mail-type=ALL
#SBATCH --mail-user corinne.olivero.6280@student.uu.se

# Load modules
module load bioinfo-tools
module load blast

# Variables
FILE="/home/cool6280/project_genome_analysis/Genome_analysis/analyses/DNA_analyses/01_canu/my_DNA_assembly.contigs.fasta"
IN="/home/cool6280/ysk_ref.fasta"
OUT="/home/cool6280/project_genome_analysis/Genome_analysis/analyses/Synteny_comparison"


# Commands

blastn -subject $FILE -query $IN -outfmt 6 > $OUT/blast_out.txt
