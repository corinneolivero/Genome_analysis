#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 01:00:00
#SBATCH -J 0201_prokka
#SBATCH --mail-type=ALL
#SBATCH --mail-user corinne.olivero.6280@student.uu.se

#Load modules
module load bioinfo-tools
module load prokka/1.45-5b58020

#Variables
INPUT="/home/cool6280/project_genome_analysis/Genome_analysis/analyses/01_canu/my_DNA_assembly.contigs.fasta"
OUTPUT="/home/cool6280/project_genome_analysis/Genome_analysis/analyses/02_prokka"

#Commands
prokka --outdir $OUTPUT --force --addgenes --genus Leptospirillum --species ferriphilum --gram neg --usegenus --prefix Leptospirillum $INPUT
