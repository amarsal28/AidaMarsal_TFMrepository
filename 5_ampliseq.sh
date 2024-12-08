nextflow run /soft/nf-core-ampliseq_2.12.0/2_12_0 \
    -profile apptainer \
    --input_fasta /media/sf_compartida/mice_TFM/mice_ASV/77_LB3C2_M0.fasta \
    --outdir /media/sf_compartida/mice_TFM/Ampliseq_results \
    --FW_primer AGRGTTYGATYHTGGCTCAG \
    --RV_primer CGGTTACCTTGTTACGACTT \
    --save_intermediates 


 #--metadata "mice_metada.tsv" 


