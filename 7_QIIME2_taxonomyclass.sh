#!/bin/bash

# Per la classificació farem servir el mètode classify-sklearn
# Amb aquest mètode usem un arxiu "entrenat" a partir d'un arxiu de taxonomia i de seqüències de referència. 
# Descàrrega de l'arxiu:
wget https://data.qiime2.org/2024.2/common/silva-138-99-nb-classifier.qza o- silva_data/silva-138-99-nb-classifier.qza

mkdir qiime2/tax_class
qiime feature-classifier classify-sklearn \
    --i-classifier silva_data/silva-138-99-nb-classifier.qza \
    --i-reads qiime2/clustered/rep-seqs-or-90.qza \
    --o-classification qiime2/tax_class/table_tax_sklearn.qza \
    --p-n-jobs 1 --p-pre-dispatch 1*n_jobs --p-reads-per-batch 1


# També podem filtrar les dades per les taxes - exclourem cloroplast i mitocondria
qiime taxa filter-table \
  --i-table qiime2/clustered/table-or-90.qza \
  --i-taxonomy qiime2/tax_class/table_tax_sklearn.qza \
  --p-mode contains \
  --p-exclude 'Chloroplast,Mitochondria' \
  --o-filtered-table qiime2/tax_class/table_tax_sklearn_filtered.qza

# Com hem tret alguns ASVs de la taula, també ho podem filtrar per les seqüències
qiime feature-table filter-seqs \
  --i-data qiime2/clustered/rep-seqs-or-90.qza \
  --i-table qiime2/tax_class/table_tax_sklearn_filtered.qza \
  --o-filtered-data qiime2/clustered/rep-seqs-filtered.qza


# Resumim els resultats
qiime metadata tabulate \
    --m-input-file qiime2/tax_class/table_tax_sklearn.qza \
    --o-visualization qiime2/tax_class/table_tax_sklearn.qzv

qiime tools export \
    --input-path qiime2/tax_class/table_tax_sklearn.qzv \
    --output-path qiime2/tax_class/table_tax_sklearn

# Generem un gràfic interactiu per visualitzar les abundàncies de cada taxa, en cada mostra, mitjançant barres apilades
qiime taxa barplot \
    --i-table qiime2/clustered/table-or-90.qza \
    --i-taxonomy qiime2/tax_class/table_tax_sklearn.qza \
    --m-metadata-file mice_metadata.tsv \
    --o-visualization qiime2/tax_class/taxa-barplots-sklearn.qzv

qiime tools export \
    --input-path qiime2/tax_class/taxa-barplots-sklearn.qzv \
    --output-path qiime2/tax_class/taxa-barplots-sklearn