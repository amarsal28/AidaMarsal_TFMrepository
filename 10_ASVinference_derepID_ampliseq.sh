# Inferència de ASVs de totes les mostres, deixant constància de la mostra i la seqüència
mkdir mice_data/ASV_inference
vsearch --derep_id ./mice_data/mice_all_fasta.fasta \
    --output ./mice_data/ASV_inference/mice_ASV.fasta \
    --sizeout \
    --lengthout \
    --relabel_keep

# Execució ampliseq
export NXF_SINGULARITY_CACHEDIR=base_directory
export SINGULARITY_TMPDIR=base_directory

nextflow run /soft/nf-core-ampliseq_2.12.0/2_12_0 \
    -profile singularity \
    --input_fasta mice_data/ASV_inference/mice_ASV.fasta \
    --outdir Ampliseq_results \
    --FW_primer AGRGTTYGATYHTGGCTCAG \
    --RV_primer CGGTTACCTTGTTACGACTT \
    --qiime_ref_taxonomy silva=138 \
    --metadata mice_data/mice_metadata.tsv \
    --ancombc \
    --save_intermediates