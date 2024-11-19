mkdir Results

nextflow run ./ampliseq \
    -profile singularity \
    --input_fasta "mice.fasta" \
    --FW_primer AGRGTTYGATYHTGGCTCAG \
    --RV_primer CGGTTACCTTGTTACGACTT \
    --metadata mice_metada.tsv \
    --outdir "Results"
