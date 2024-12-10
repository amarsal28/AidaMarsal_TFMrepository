#!/bin/bash

# Per la classificació farem servir el mètode classify-sklearn
# Amb aquest mètode usem un arxiu "entrenat" a partir d'un arxiu de taxonomia i de seqüències de referència. 
# Descàrrega de l'arxiu:
wget https://data.qiime2.org/2024.2/common/silva-138-99-nb-classifier.qza o- silva_data/silva-138-99-nb-classifier.qza

mkdir qiime2/tax_class
qiime feature-classifier classify-sklearn \
    --i-classifier silva_data/silva-138-99-nb-classifier.qza \
    --i-reads qiime2/clustered/rep-seqs-or-90.qza \
    --o-classification qiime2/tax_class/table-or-90.tax.sklearn.qza \
    --p-reads-per-batch 100

qiime metadata tabulate \
    --m-input-file qiime2/tax_class/table-or-90.tax.sklearn.qza \
    --o-visualization qiime2/tax_class/table-or-90.tax.sklearn.qzv

qiime tools export \
    --input-path qiime2/tax_class/table-or-90.tax.sklearn.qzv \
    --output-path table-or-90.tax.sklearn
