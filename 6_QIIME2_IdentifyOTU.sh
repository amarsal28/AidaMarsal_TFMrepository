#!/bin/bash

# Per fer el clustering utilitzarem open-reference clustering
mkdir qiime2/clustered
qiime vsearch cluster-features-open-reference \
    --i-table qiime2/dereplicates/table.qza \
    --i-sequences qiime2/dereplicates/rep-seqs.qza \
    --i-reference-sequences silva_data/silva-138-99-seqs.qza \
    --p-perc-identity 0.90 \
    --o-clustered-table qiime2/clustered/table-or-90.qza \
    --o-clustered-sequences qiime2/clustered/rep-seqs-or-90.qza \
    --o-new-reference-sequences qiime2/clustered/new-ref-seqs-or-90.qza \
    --p-threads 4

# Resumir taula de clusters amb metadata
qiime feature-table summarize \
    --i-table qiime2/clustered/table-or-90.qza \
    --o-visualization qiime2/clustered/table-or-90.qzv \
    --m-sample-metadata-file mice_metadata.tsv