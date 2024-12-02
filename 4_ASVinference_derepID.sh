mkdir ASV_infered2
vsearch --derep_id ./mice_fasta/mice_all_fasta.fasta \
    --output ASV_infered2/mice_ASV.fasta \
    --sizeout \
    --lengthout \
    --relabel_keep
    