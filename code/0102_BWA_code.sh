#!/bin/bash -l

#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 07:00:00
#SBATCH -J 0102_BWA_code.sh
#SBATCH --mail-type=ALL
#SBATCH --mail-user corinne.olivero.6280@student.uu.se

# Load modules
module load bioinfo-tools
module load bwa
module load samtools

# Variables
INPUT="/home/cool6280/project_genome_analysis/raw_data/RNA_trimmed_reads"
REF="/home/cool6280/project_genome_analysis/Genome_analysis/analyses/DNA_analyses/01_canu/my_DNA_assembly.contigs.fasta"

# BWA index
cd $SNIC_TMP/
bwa index $REF -p lferrdb

running_bwa() {
  # Create a unique output directory for this run
  OUTDIR="/proj/genomeanalysis2023/nobackup/work/cool6280/bwa_output/"
  mkdir -p "$OUTDIR"

  bwa mem lferrdb $INPUT/${i}_P1.trim.fastq.gz $INPUT/${i}_P2.trim.fastq.gz | samtools view -S -b | samtools sort -o ${i}_bwa_sorted.bam
  samtools index ${i}_bwa_sorted.bam
  cp ${i}_bwa_sorted.bam "$OUTDIR"
}


for i in ERR2036629 ERR2036630 ERR2036631 ERR2036632 ERR2036633 ERR2117288 ERR2117289 ERR2117290 ERR2117291 ERR2117292
do
  running_bwa "$i" &
done
wait


