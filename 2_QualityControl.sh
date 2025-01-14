#!/bin/bash

# Control de qualitat amb NanoPlot
# Generem un bucle per recorrer tots els arxius i fer el control de qualitat
for fastq in mice_data/mice_fastq/*.fastq.gz;
do
    # Definim el nom de l'arxiu sense extensió
    fastq_name=$(basename "$fastq" .fastq.gz)

    # Creem una carpeta específica per cada mostra
    mkdir -p QualityResults/QC_Results/NanoPlot_QC/"$fastq_name"

    # Executem NanoPlot
    NanoPlot --fastq "$fastq" -o QualityResults/QC_Results/NanoPlot_QC/"$fastq_name" -t 4 --title "$fastq_name Report" --prefix "$fastq_name" --plots kde dot
done


# Control de qualitat amb FastQC
mkdir -p QualityResults/QC_Results/FastQC_results
fastqc -o QualityResults/QC_Results/FastQC_results mice_data/mice_fastq/*.fastq.gz


# Generació de document multiQC
multiqc ./QualityResults/QC_Results/ --filename multiQC_report --outdir QualityResults/QC_Results
