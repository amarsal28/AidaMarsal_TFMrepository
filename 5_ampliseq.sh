nextflow run ./ampliseq \
    -profile singularity \
    --input_fasta ./ASV_infered2/mice_ASV.fasta \
    --outdir "Ampliseq_results" \
    --FW_primer AGRGTTYGATYHTGGCTCAG \
    --RV_primer CGGTTACCTTGTTACGACTT \
    --qiime_ref_taxonomy silva=138 \
    
        #--metadata "mice_metadata.tsv" \
