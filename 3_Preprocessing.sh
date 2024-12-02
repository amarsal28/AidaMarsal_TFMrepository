#!/bin/bash

# Utilitzem porechop per treure adaptadors i eliminar quimeres. 
# Primer instal·lem la funció:
if ! command -v porechop &> /dev/null; then
    sudo apt install porechop
fi


# Creem una nova carpeta per guardar els arxius trimmed:
mkdir mice_fastq_trimmed

# Generem un bucle per aplicar porechop a tots els nostres arxius de seqüenciació:
for fastq in mice_fastq/*.fastq.gz;
do
    # Definim el nom de l'arxiu sense extensió
    fastq_name=$(basename "$fastq" .fastq.gz)

    # Executem porechop
    porechop -i "$fastq" --check_reads 1000 -t 4 | gzip > ./mice_fastq_trimmed/"$fastq_name"_trimmed.fastq.gz
done

# El que passem a fer és eliminar les seqüencies amb una qualitat inferior a 10, així com eliminarem les seqüencies de menys de 1000 bp i les de més de 2000bp
# Instal·lem la funció fastp per fer-ho: 
if ! command -v fastp &> /dev/null; then
    sudo apt install fastp
fi

# Creem una nova carpeta on guardarem els arxius resultants
mkdir mice_fastq_processed

for fastq in mice_fastq_trimmed/*.fastq.gz;
do
    # Definim el nom de l'arxiu sense extensió
    fastq_name=$(basename "$fastq" .fastq.gz)

    # Executem fastp - amb -A bloquegem el trimming, i amb -G bloquegem eliminació de cues poly-G
    fastp -i "$fastq" --stdout -A -G -q 10 -l 1000 --length_limit 2000 -w 4 | gzip > ./mice_fastq_processed/"$fastq_name"_trimmed2.fastq.gz
done