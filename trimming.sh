#!/bin/bash

#Instalar cutadapt si no es té instalat: 
# apt install cutadapt

mkdir mice_data_trimmed_test

for file in mice_data/*.fastq.gz; 
do
    file_name=$(basename "$file" .fastq.gz)
    cutadapt -g AGRGTTYGATYHTGGCTCAG -a CGGTTACCTTGTTACGACTT \
    --discard-untrimmed \
    -q 20 \
    --fasta \
    -o mice_data_trimmed/"${file_name}.fasta \
    "$file"
done

# q: filtrat de qualitat - retalla les bases amb calitat inferior a 20 (phred score) - 99% de precisió en la trucada de bases. 

#Usage:
    #cutadapt -a ADAPTER [options] [-o output.fastq] input.fastq
    #Replace "ADAPTER" with the actual sequence of your 3' adapter

    #Citation:Marcel Martin. Cutadapt removes adapter sequences from high-throughput sequencing reads. EMBnet.Journal, 17(1):10-12, May 2011.
    #http://dx.doi.org/10.14806/ej.17.1.200
