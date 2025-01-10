#!/bin/bash

# Alineament múltiple de seqüències representatives, en un sol pas
mkdir qiime2/alignment

qiime phylogeny align-to-tree-mafft-fasttree \
    --i-sequences qiime2/clustered/rep-seqs-or-90.qza \
    --o-alignment qiime2/alignment/aligned-rep-seqs-or-90.qza \
    --o-masked-alignment qiime2/alignment/masked-aligned-rep-seqs-or-90.qza \
    --o-tree qiime2/alignment/unrooted-tree.qza \
    --o-rooted-tree qiime2/alignment/rooted-tree.qza \
    --p-n-threads 24





