mkdir qiime2/ancomb
qiime composition ancombc \
    --i-table qiime2/tax_class/table_tax_sklearn.qza \
    --m-metadata-file mice_metadata.tsv \
    --p-formula 'Genotype' \
    --p-level 6 \
    --o-differentials qiime2/ancomb/ancombc-genotype.qza

qiime composition da-barplot \
    --i-data qiime2/ancomb/ancombc-genotype.qza \
    --p-significance-threshold 0.001 \
    --o-visualization qiime2/ancomb/ancombc-genotype-barplot.qzv


