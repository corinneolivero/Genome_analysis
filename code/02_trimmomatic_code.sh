#!/bin/bash -l

#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J 02_trimmomatic_code.sh
#SBATCH --mail-type=ALL
#SBATCH --mail-user corinne.olivero.6280@student.uu.se

# Load modules
module load bioinfo-tools
module load trimmomatic

# Run trimmomatic
java -jar $TRIMMOMATIC_HOME/trimmomatic.jar \
PE -threads 4 -phred33 \
 /home/cool6280/project_genome_analysis/raw_data/RNA_raw_data/ERR2036629_1.fastq.gz \
 /home/cool6280/project_genome_analysis/raw_data/RNA_raw_data/ERR2036629_2.fastq.gz \
 /home/cool6280/project_genome_analysis/Genome_analysis/analyses/RNA_analyses/02_trimmomatic/forward_paired \
 /home/cool6280/project_genome_analysis/Genome_analysis/analyses/RNA_analyses/02_trimmomatic/forward_unpaired \
 /home/cool6280/project_genome_analysis/Genome_analysis/analyses/RNA_analyses/02_trimmomatic/reverse_paired \
 /home/cool6280/project_genome_analysis/Genome_analysis/analyses/RNA_analyses/02_trimmomatic/reverse_unpaired \
 ILLUMINACLIP:$TRIMMOMATIC_HOME/adapters/TruSeq3-PE.fa:2:30:10 \
 LEADING:20 \
 TRAILING:20 \
 SLIDINGWINDOW:1:3 \
 MINLEN:40 \
 MAXINFO:40:0.5;
