#!/bin/bash

# Utilitzem porechop per treure adaptadors i eliminar quimeres. 
# Creem una nova carpeta per guardar els arxius trimmed:
mkdir mice_fastq_trimmed

# Generem un bucle per aplicar porechop a tots els nostres arxius de seqüenciació:
for fastq in mice_fastq/*.fastq.gz;
do
    # Definim el nom de l'arxiu sense extensió
    fastq_name=$(basename "$fastq" .fastq.gz)

    # Executem porechop
    porechop -i "$fastq" -t 4 -o ./mice_fastq_trimmed/"$fastq_name"_trimmed.fastq.gz
done

# Fem servir fastplong (específic per seqüències llargues) per eliminar les seqüencies amb una qualitat inferior a 15, així com eliminarem les seqüencies de menys de 1000 bp.
# Creem una nova carpeta on guardarem els arxius resultants
mkdir mice_fastq_processed

# Generem un bucle per aplicar fastplong a totes les dades:
for fastq in mice_fastq_trimmed/*.fastq.gz;
do
    # Definim el nom de l'arxiu sense extensió
    fastq_name=$(basename "$fastq" .fastq.gz)

    # Executem fasplong
    fastplong -i "$fastq" -q 15 -l 1000  -out ./mice_fastq_processed/"$fastq_name"_trimmed2.fastq.gz
done