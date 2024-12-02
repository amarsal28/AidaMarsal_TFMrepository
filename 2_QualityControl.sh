#!/bin/bash

# Control de qualitat amb NanoPlot

# Descarreguem el paquet
if ! pip show NanoPlot > /dev/null 2>&1; then
    pip install NanoPlot
fi

# Generem un bucle per recorrer tots els arxius i fer el control de qualitat
for fastq in mice_fastq/*.fastq.gz;
do
    # Definim el nom de l'arxiu sense extensió
    fastq_name=$(basename "$fastq" .fastq.gz)

    # Creem una carpeta específica per cada mostra
    mkdir -p QC_Results/NanoPlot_QC/"$fastq_name"

    # Executem NanoPlot
    NanoPlot --fastq "$fastq" -o QC_Results/NanoPlot_QC/"$fastq_name" -t 4 --title "$fastq Report" --plots kde dot
done


# Control de qualitat amb NanoQC

# Descarreguem el paquet NanoQC
if ! pip show nanoQC > /dev/null 2>&1; then
    pip install nanoQC
fi

# Executem el codi
for fastq in mice_fastq/*.fastq.gz;
do
    # Definim el nom de l'arxiu sense extensió
    fastq_name=$(basename "$fastq" .fastq.gz)

    # Creem una carpeta específica per cada mostra
    mkdir -p QC_Results/nanoQC_results/"$fastq_name"

    # Executem NanoPlot
    nanoQC -o QC_Results/nanoQC_results/"$fastq_name" "$fastq"
done

# Generació de document multiQC
multiqc ./QC_Results
