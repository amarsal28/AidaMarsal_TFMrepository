#!/bin/bash

# Control de qualitat amb NanoPlot
# Generem un bucle per recorrer tots els arxius i fer el control de qualitat
for fastq in mice_fastq/*.fastq.gz;
do
    # Definim el nom de l'arxiu sense extensió
    fastq_name=$(basename "$fastq" .fastq.gz)

    # Creem una carpeta específica per cada mostra
    mkdir -p QC_Results/NanoPlot_QC/"$fastq_name"

    # Executem NanoPlot
    NanoPlot --fastq "$fastq" -o QC_Results/NanoPlot_QC/"$fastq_name" -t 4 --title "$fastq_name Report" --prefix "$fastq_name" --plots kde dot
done


# Control de qualitat amb FastQC
mkdir -p QC_Results/FastQC_results
fastqc -o QC_Results/FastQC_results mice_fastq/*.fastq.gz


# Generació de document multiQC
multiqc ./QC_Results/ --filename multiQC_report --outdir QC_Results
