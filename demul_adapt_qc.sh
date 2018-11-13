#!/bin/bash
#Demultiplex a single fastq file into multiple files
#Decided to hold off on this. Was demultiplexing a single fastq into multiple fastq's mentioned as being wanted in the script by the prof? Do we assume we have barcode read fastq files as well? Adds a lot of complexity
#AfterQC is being used for automatic adaptor cutting, trimming and report generation. The folder created named good has the reads that passed. You can replace pypy with python to get it to run on your pc if you do not have pypy installed, but pypy is much faster.

#Rename any .fq files in the user directory to .fastq for simplicity
fqfiles=`ls $DATA *.fq | wc -l`
if [ "$fqfiles" != 0 ];then
rename.ul .fq .fastq *.fq
fi

#Obtain path of after.py from user
echo "Please enter the complete path to after.py for the program AfterQC"
read afqcl
AFQCL=$afqcl

#AfterQC requires files to have R1 in the name even if they are single
if [ "$sq_type" == "single" ];then
cd $DATA
rename.ul .fastq _R1.fastq *.fastq
pypy $afqcl -f -1 -t -1
cd good
fi

#For paired reads 
if [ "$sq_type" == "paired" ];then
cd $DATA
echo "Please ensure the paired sequences have R1 and R2 in the names respectively"
pypy $afqcl -f -1 -t -1
cd good
fi