#!/bin/bash

#Create a new folder for running this for loop test
echo -e "Making the necessary directories...\n"
cd ~/MCB201B_F2024/Week_9
mkdir loop_folder

#Make other directories that we'll need
echo -e "Making other directories as needed...\n"
mkdir ./loop_folder/seq_view
mkdir ./loop_folder/fastqc_results
echo -e "Done making directories! \n"

#Change to the shared folder to keep things nice and tidy
cd ~/shared/course/mcb201b-shared-readwrite/rna/g1

#Set up all the basenames that we'll use
echo -e "Setting up the basenames and paths to use...\n"

truncated=1M_
trunc_reads=first_ten_reads_
use_this=~/MCB201B_F2024/Week_9/loop_folder

#Set up our for loop
for filename in *.fastq.gz; do
    echo -e "Truncating ${filename}...\n"
    zcat $filename | head -n 4000000 > $use_this/$truncated${filename%.gz}
    echo -e "Done truncating ${filename}...\n"
    echo -e "Creating txt of 1st 10 reads for ${filename}...\n"
    head -n 40 $use_this/$truncated${filename%.gz} > $use_this/seq_view/$trunc_reads${filename%.fastq.gz}.txt
    echo -e "Done creating the txt file of 1st ten reads for ${filename}!"
    echo -e "Starting fastqc analysis for ${filename}...\n"
    fastqc -o $use_this/fastqc_results $use_this/$truncated${filename%.gz}
done

echo "Done!"






