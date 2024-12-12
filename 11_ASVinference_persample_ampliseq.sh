# Dereplicació
mkdir mice_data/ASV_inference2

for fasta in mice_data/mice_fasta/*.fasta;
do
    # Definim el nom de l'arxiu sense extensió
    fasta_name=$(basename "$fasta" .fasta)

    # Executem vsearch per dereplicar cada una de les mostres 
    vsearch --fastx_uniques '$fasta' --fastaout mice_data/ASV_inference2/'$fasta_name'.fasta --relabel uniq --sizeout --lengthout
done

# Ampliseq en bucle per aplicar-ho a cada mostra
for fasta in mice_data/ASV_inference2;
do
    fasta_name=$(basename "$fasta" .fasta)
    nextflow run /soft/nf-core-ampliseq_2.12.0/2_12_0 \
        -profile singularity \
        --input_fasta "$fasta" \
        --outdir Ampliseq_results/'$fasta_name'\
        --FW_primer AGRGTTYGATYHTGGCTCAG \
        --RV_primer CGGTTACCTTGTTACGACTT \
        --qiime_ref_taxonomy silva=138 \
        --metadata mice_data/mice_metadata.tsv \
        --ancombc \
        --save_intermediates
done