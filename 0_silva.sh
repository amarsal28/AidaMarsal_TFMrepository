#!/bin/bash

# Descarreguem la base de dades silva v138 en format QIIME2
# Per la identificació de OTUs fer servir estratègia closed-reference, o open-reference
mkdir silva_data
wget https://data.qiime2.org/2023.7/common/silva-138-99-seqs.qza -O silva_data/silva-138-99-seqs.qza
wget https://data.qiime2.org/2023.7/common/silva-138-99-tax.qza -O silva_data/silva-138-99-tax.qza
wget https://resources.qiime2.org/2024.5/common/silva-138-99-nb-classifier.qza o- silva_data/silva-138-99-nb-classifier.qza