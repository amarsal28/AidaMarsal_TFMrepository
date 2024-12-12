#!/bin/bash

for fastq in mice_data/mice_fastq_processed/*.fastq.gz;
do
    # Definim el nom de l'arxiu sense extensió
    fastq_name=$(basename "$fastq" _trimmed2.fastq.gz)

    # Executem seqtk (-A per indicar que passi de fastq a fasta)
    seqtk seq -A "$fastq" > ./mice_data/mice_fasta/"$fastq_name".fa

    # Renombrar les nostres seqüències per distingir cada mostra i cada seqüència
    awk -v sample_name="$fastq_name" '/^>/ {print ">" sample_name "_" ++seq_id} !/^>/ {print}' ./mice_data/mice_fasta/"$fastq_name".fa > ./mice_data/mice_fasta/"$fastq_name"_renamed.fa
    
    # Reemplazamos el archivo original por el renombrado
    mv ./mice_data/mice_fasta/"$fastq_name"_renamed.fa ./mice_data/mice_fasta/"$fastq_name".fa
done

# Concatenació dels arxius FASTA de totes les mostres
cat mice_data/mice_fasta/*.fa > mice_data/mice_all_fasta.fasta