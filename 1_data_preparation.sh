#!/bin/bash

# Descomprimim l'arxiu, i posem un nom més fàcil a la carpeta - "mice_fastq"
unrar x 'Archivos fastq_23OT00046.rar'
mv 'Archivos fastq_23OT00046' mice_fastq

# Modifiquem el nom dels arxius fastq (perque no tinguin espais) i els comprimim en .gz
for doc in mice_fastq/*.fastq; 
do
  name=$(echo "$doc" | tr ' \-' '_')
  mv "$doc" "$name"
  gzip "$name"
done
