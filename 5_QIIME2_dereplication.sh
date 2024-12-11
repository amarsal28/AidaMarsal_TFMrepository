#!/bin/bash

mkdir qiime2/dereplicates

# Importem les seqüències
qiime tools import \
    --input-path mice_fasta/mice_all_fasta.fasta \
    --output-path qiime2/sequences.qza \
    --type 'SampleData[Sequences]'

# Dereplicació de seqüències (agrupar seqüències idèntiques)
qiime vsearch dereplicate-sequences \
    --i-sequences qiime2/sequences.qza \
    --o-dereplicated-table qiime2/dereplicates/table.qza \
    --o-dereplicated-sequences qiime2/dereplicates/rep-seqs.qza

# Visualització del resultat (aquí també es pot afegir informació dels grups - metadata)
qiime feature-table summarize \
    --i-table qiime2/dereplicates/table.qza \
    --o-visualization qiime2/dereplicates/tableviz.qzv

qiime tools export \
    --input-path qiime2/dereplicates/tableviz.qzv \
    --output-path qiime2/dereplicates/tableviz
