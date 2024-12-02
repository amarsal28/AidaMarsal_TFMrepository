#!/bin/bash

# Conversió d'arxius FASTQ en FASTA
# Instal·lem seqtk per fer la conversió:
if ! command -v seqtk &> /dev/null; then
    sudo apt install seqtk
fi

# Creem carpeta per guardar els FASTAs
mkdir mice_fasta

# Generem un bucle per convertir en FASTA tots els fastq processats
for fastq in mice_fastq_processed/*.fastq.gz;
do
    # Definim el nom de l'arxiu sense extensió
    fastq_name=$(basename "$fastq" _trimmed2.fastq.gz)

    # Executem seqtk (-A per indicar que passi de fastq a fasta)
    seqtk seq -A "$fastq" > ./mice_fasta/"$fastq_name".fa

    #Renombrar les nostres seqüències per distingir cada mostra
    sed -i "s/^>.*/>${fastq_name}/" ./mice_fasta/"$fastq_name".fa 
done

# Concatenació dels arxius FASTA de totes les mostres
cat mice_fasta/*.fa > mice_fasta/mice_all_fasta.fasta

# Dereplicació
mkdir ASV_results
vsearch --fastx_uniques ./mice_fasta/mice_all_fasta.fasta --fastaout ASV_results/mice_ASV.fasta --relabel uniq --sizeout --lengthout

# Clustering
vsearch --cluster_size ASV_results/mice_ASV.fasta --centroids ASV_results/mice_ASVclusters.fasta --id 1.0 --sizeout --lengthout