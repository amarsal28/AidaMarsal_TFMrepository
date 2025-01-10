# Alpha diversitat i rarefacció [p-max-depth depen de la mostra amb més lectures]
qiime diversity alpha-rarefaction \
    --i-phylogeny qiime2/alignment/rooted-tree.qza \
    --i-table qiime2/tax_class/table_tax_sklearn_filtered2.qza \
    --p-max-depth 24863 \
    --p-metrics shannon observed_features\
    --o-visualization qiime2/diversity/alpha-rarefaction.qzv

qiime tools export \
    --input-path qiime2/diversity/alpha-rarefaction.qzv \
    --output-path qiime2/diversity/rarefaction-curve

# Rarefacció
qiime feature-table rarefy \
    --i-table qiime2/tax_class/table_tax_sklearn_filtered2.qza \
    --p-sampling-depth 6407 \
    --o-rarefied-table qiime2/tax_class/table_rarefied.qza

qiime tools export \
    --input-path qiime2/tax_class/table_rarefied.qza6407 \
    --output-path qiime2/diversity/table_rarefied
