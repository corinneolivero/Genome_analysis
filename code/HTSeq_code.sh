#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 10:00:00
#SBATCH -J HTSeq_code.sh
#SBATCH --mail-type=ALL
#SBATCH --mail-user corinne.olivero.6280@student.uu.se

# Load modules
module load bioinfo-tools
module load htseq

#Variables
INPUT="/proj/genomeanalysis2023/nobackup/work/cool6280/bwa_output"
REF="/home/cool6280/Lepto_edited_edited.txt"

cd $SNIC_TMP/

for i in ERR2036629 ERR2036630 ERR2036631 ERR2036632 ERR2036633 ERR2117288 ERR2117289 ERR2117290 ERR2117291 ERR2117292
do 
   # Run htseq-count on bam file
   htseq-count -f bam -r pos -s reverse -t CDS -i ID $INPUT/${i}_bwa_sorted.bam $REF > ${i}_count.txt
   cp ${i}_count.txt /home/cool6280/project_genome_analysis/Genome_analysis/analyses/RNA_analyses/05_HTSeq 
  
done
