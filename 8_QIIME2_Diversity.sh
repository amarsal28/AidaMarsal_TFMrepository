#!/bin/bash

# Alineament múltiple de seqüències representatives, en un sol pas
mkdir qiime2/alignment

qiime phylogeny align-to-tree-mafft-fasttree \
    --p-n-threads 4 --p-parttree\
    --i-sequences qiime2/clustered/rep-seqs-or-90.qza \
    --o-alignment qiime2/alignment/aligned-rep-seqs-or-90.qza \
    --o-masked-alignment qiime2/alignment/masked-aligned-rep-seqs-or-90.qza \
    --o-tree qiime2/alignment/unrooted-tree.qza \
    --o-rooted-tree qiime2/alignment/rooted-tree.qza
    

qiime tools export \
    --input-path qiime2/alignment/rooted-tree.qza \
    --output-path qiime2/alignment/rooted-tree


# Diversity core-metrics
mkdir qiime2/diversity
qiime diversity core-metrics-phylogenetic \
    --i-phylogeny qiime2/alignment/rooted-tree.qza \
    --i-table qimme2/clustered/table-or-90.qza \
    --p-sampling-depth 15000 \
    --m-metadata mice_metadata.tsv \
    --output-dir qiime2/diversity/core-metrics-results

# Associació de metadata i alfa-diversitat amb shannon-index
qiime diversity alpha-group-significance \
    --i-alpha-diversity qiime2/diversity/core-metrics-results/shannon_vector.qza \
    --m-metadata-file mice_metadata.tsv \
    --o-visualization qiime2/diversity/shannon-group-significance.qzv


# Significance per variables categòriques. 
# Per variables continues hauriem de fer servir correlation, però en el nostre cas no tenim.

# beta-diversitat - diferències entre grups - genotip, tumor, familia
qiime diversity beta-group-significance \
    --i-distance-matrix qiime2/diversity/unweighted_unifrac_distance_matrix.qza \
    --m-metadata-file mice_metadata.tsv \
    --m-metadata-column genotype \
    --o-visualization qiime2/diversity/beta-group-genotype.qzv


qiime diversity beta-group-significance \
    --i-distance-matrix qiime2/diversity/unweighted_unifrac_distance_matrix.qza \
    --m-metadata-file mice_metadata.tsv \
    --m-metadata-column family \
    --o-visualization qiime2/diversity/beta-group-family.qzv
 

qiime diversity beta-group-significance \
    --i-distance-matrix qiime2/diversity/unweighted_unifrac_distance_matrix.qza \
    --m-metadata-file mice_metadata.tsv \
    --m-metadata-column "HCC (YES/NO)" \
    --o-visualization qiime2/diversity/beta-group-genotype.qzv


# Alpha diversitat i rarefacció [p-max-depth depen de la mostra amb menys lectures]

qiime diversity alpha-rarefaction \
    --i-phylogeny qiime2/alignment/rooted-tree.qza \
    --i-table qimme2/clustered/table-or-90.qza \
    --p-max-depth 12500 \
    --p-metrics shannon faith_pd\
    --m-metadata-file mice_metadata.tsv \
    --o-visualization qiime/diversity/alpha-rarefaction.qzv

