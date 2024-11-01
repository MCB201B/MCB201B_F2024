#!/bin/bash

#Create needed directories
cd ~/MCB201B_F2024/Week_10
echo -e "Making directories to keep alignment outputs tidy...\n"
mkdir ./alignment-outputs
mkdir ./alignment-outputs/logs
mkdir ./alignment-outputs/sams
mkdir ./alignment-outputs/bams

#Define PATH to HISAT2
echo -e "Setting path to HISAT2...\n"
PATH=$PATH:/home/jovyan/shared/course/mcb201b-shared-readwrite/hisat2-2.2.1

#Align truncated RNA-seq data
echo -e "Setting up a for loop to run alignments...\n"
#Change folder to keep file names tidier
cd ~/MCB201B_F2024/Week_9/truncated_data

#Set up our lists for our for loop
mate_1=(*_r1.fastq)
mate_2=(*_r2.fastq)
#echo ${mate_1[$i]} ${mate_2[$i]}

#File path variable
output_to_use=~/MCB201B_F2024/Week_10/alignment-outputs

for ((i=0; i<${#mate_1[@]}; i++)); do
    #running hisat2 using the two lists we set up
    echo -e "Running HISAT2 for ${mate_1[$i]%_r1.fastq} to align to hg19 genome...\n"
    hisat2 -x ~/shared/course/mcb201b-shared-readwrite/rna-index/hg19 -1 ${mate_1[$i]} -2 ${mate_2[$i]} --rna-strandness RF -S $output_to_use/sams/${mate_1[$i]%_r1.fastq}.sam --summary-file $output_to_use/logs/${mate_1[$i]%_r1.fastq}_alignment_log.txt --new-summary
    #we want to pull out 100 rows from our SAM file to look at later
    echo -e "Pulling out rows from ${mate_1[$i]%_r1.fastq} alignment to look at later...\n"
    head -n 100 $output_to_use/sams/${mate_1[$i]%_r1.fastq}.sam > $output_to_use/logs/${mate_1[$i]%_r1.fastq}_sam_trunc.txt
    #Convert SAM to BAM
    echo -e "Converting the alignment for ${mate_1[$i]%_r1.fastq} from a SAM to a BAM...\n"
    samtools view -b -o $output_to_use/bams/${mate_1[$i]%_r1.fastq}.bam $output_to_use/sams/${mate_1[$i]%_r1.fastq}.sam
    #Delete our SAM file to save some storage
    echo -e "Deleting SAM files to save memory...\n"
    rm $output_to_use/sams/${mate_1[$i]%_r1.fastq}.sam
    echo -e "Sorting BAM files by position and then indexing...\n"
    samtools sort -o $output_to_use/bams/${mate_1[$i]%_r1.fastq}_position.bam $output_to_use/bams/${mate_1[$i]%_r1.fastq}.bam
    samtools index $output_to_use/bams/${mate_1[$i]%_r1.fastq}_position.bam
    #Sort our BAM file by name for HTSeq
    echo -e "Sorting the BAM file by name for later counting...\n"
    samtools sort -n -o $output_to_use/bams/${mate_1[$i]%_r1.fastq}_name.bam $output_to_use/bams/${mate_1[$i]%_r1.fastq}.bam
done

multiqc --outdir ~/MCB201B_F2024/Week_10/multiqc_output $output_to_use/logs

echo "Done!"