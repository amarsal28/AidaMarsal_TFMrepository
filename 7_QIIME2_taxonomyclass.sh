#!/bin/bash

# Per la classificació farem servir el mètode classify-sklearn, i usem un arxiu "entrenat" a partir d'un arxiu de taxonomia i de seqüències de referència. 
mkdir qiime2/tax_class
qiime feature-classifier classify-sklearn \
    --i-classifier silva_data/silva_classifier.qza \
    --i-reads qiime2/clustered/rep-seqs-or-90.qza \
    --o-classification qiime2/tax_class/table_tax_sklearn.qza 

# També podem filtrar les dades per taxons - exclourem cloroplast, mitocondri, eucariotes i NA.
qiime taxa filter-table \
  --i-table qiime2/clustered/table-or-90.qza \
  --i-taxonomy qiime2/tax_class/table_tax_sklearn.qza \
  --p-mode contains \
  --p-exclude 'Chloroplast,Mitochondria,NA,d__Eukaryota' \
  --o-filtered-table qiime2/tax_class/table_tax_sklearn_filtered.qza

qiime feature-table summarize \
    --i-table qiime2/tax_class/table_tax_sklearn_filtered.qza \
    --o-visualization qiime2/tax_class/table_tax_sklearn_filtered.qzv

# Generem un gràfic interactiu per visualitzar les abundàncies de cada taxa, en cada mostra, mitjançant barres apilades
qiime taxa barplot \
    --i-table qiime2/clustered/table-or-90.qza \
    --i-taxonomy qiime2/tax_class/table_tax_sklearn_filtered.qza \
    --m-metadata-file mice_data/mice_metadata.tsv \
    --o-visualization qiime2/tax_class/taxa-barplots-sklearn.qzv

qiime tools export \
    --input-path qiime2/tax_class/taxa-barplots-sklearn.qzv \
    --output-path qiime2/tax_class/taxa-barplots-sklearn
