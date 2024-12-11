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
    fastplong -i "$fastq" -q 15 -l 1000 \
    -out ./mice_fastq_processed/"$fastq_name"_trimmed2.fastq.gz \
    -h ./mice_fastp_reports/"$fastq_name"_fastp.html \
    -j ./mice_fastp_reports/"$fastq_name"_fastp.json
done


## Passem el control de qualitat
# Control de qualitat amb NanoPlot
# Generem un bucle per recorrer tots els arxius i fer el control de qualitat
for fastq in mice_fastq_processed/*.fastq.gz;
do
    # Definim el nom de l'arxiu sense extensió
    fastq_name=$(basename "$fastq" .fastq.gz)

    # Creem una carpeta específica per cada mostra
    mkdir -p QC_Results_postProcessing/NanoPlot_QC/"$fastq_name"

    # Executem NanoPlot
    NanoPlot --fastq "$fastq" -o QC_Results_postProcessing/NanoPlot_QC/"$fastq_name" -t 4 --title "$fastq_name Post-processing Report" --prefix "$fastq_name" --plots kde dot
done

# Control de qualitat amb FastQC
# Executem el codi
mkdir -p QC_Results_postProcessing/FastQC_results
fastqc -o QC_Results_postProcessing/FastQC_results mice_fastq_processed/*.fastq.gz

# Generació de document multiQC
#Execució del codi
multiqc ./QC_Results_postProcessing/ --filename multiQC_report_postProcessing --outdir QC_Results_postProcessing
