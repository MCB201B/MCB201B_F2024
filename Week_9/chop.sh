#!/bin/bash

#Change to Week_9 directory just in case
echo -e "I'm changing to week_9 directory \n"
cd ~/MCB201B_F2024/Week_9

#Make directory for truncated data
echo -e "I'm making a new directory for truncated data \n"
mkdir truncated_data

#Truncate each fastq.gz file in 1M reads
echo -e "Truncating all the datasets... \n"
echo -e "truncating control_r1...\n"
zcat ~/shared/course/mcb201b-shared-readwrite/rna/g1/g1_control_r1.fastq.gz | head -n 4000000 > ./truncated_data/1M_g1_control_r1.fastq
echo -e "truncating control_r2...\n"
zcat ~/shared/course/mcb201b-shared-readwrite/rna/g1/g1_control_r2.fastq.gz | head -n 4000000 > ./truncated_data/1M_g1_control_r2.fastq
echo -e "truncating tazko_r1...\n"
zcat ~/shared/course/mcb201b-shared-readwrite/rna/g1/g1_tazko_r1.fastq.gz | head -n 4000000 > ./truncated_data/1M_g1_tazko_r1.fastq
echo -e "truncating tazko_r2...\n"
zcat ~/shared/course/mcb201b-shared-readwrite/rna/g1/g1_tazko_r2.fastq.gz | head -n 4000000 > ./truncated_data/1M_g1_tazko_r2.fastq

#Make subdirectory to hold txt files
echo -e "Making a new subdirectory to hold text files...\n"
mkdir ./truncated_data/seq_view

#Pull out first 10 reads into txt files
echo -e "Pulling out the first ten reads into some txt files...\n"
head -n 40 ./truncated_data/1M_g1_control_r1.fastq > ./truncated_data/seq_view/first_ten_g1_control_r1.txt
head -n 40 ./truncated_data/1M_g1_control_r2.fastq > ./truncated_data/seq_view/first_ten_g1_control_r2.txt
head -n 40 ./truncated_data/1M_g1_tazko_r1.fastq > ./truncated_data/seq_view/first_ten_g1_tazko_r1.txt
head -n 40 ./truncated_data/1M_g1_tazko_r2.fastq > ./truncated_data/seq_view/first_ten_g1_tazko_r2.txt

#Make a fastqc_results directory
echo -e "Making your fastqc_results directory...\n"
mkdir fastqc_results

#Perform QC on full datasets
echo -e "Now working on analyzing each fastq.gz file...\n"
echo -e "Checking control_r1...\n"
fastqc -o ./fastqc_results ~/shared/course/mcb201b-shared-readwrite/rna/g1/g1_control_r1.fastq.gz
echo -e "Checking control_r2...\n"
fastqc -o ./fastqc_results ~/shared/course/mcb201b-shared-readwrite/rna/g1/g1_control_r2.fastq.gz
echo -e "Checking tazko_r1...\n"
fastqc -o ./fastqc_results ~/shared/course/mcb201b-shared-readwrite/rna/g1/g1_tazko_r1.fastq.gz
echo -e "Checking tazko_r2...\n"
fastqc -o ./fastqc_results ~/shared/course/mcb201b-shared-readwrite/rna/g1/g1_tazko_r2.fastq.gz

echo "I'm all done!"