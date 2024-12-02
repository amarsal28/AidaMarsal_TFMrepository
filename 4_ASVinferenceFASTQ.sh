# Concatenació dels arxius FASTQ de totes les mostres
cat mice_fastq_processed/*.fastq.gz > mice_fastq_processed/mice_all_fastq.fastq

# Dereplicació
mkdir ASV_infered
vsearch --fastx_uniques ./mice_fastq_processed/mice_all_fastq.fastq \
    --fastaout ASV_infered/mice_ASV.fasta \
    --sizeout \
    --lengthout \
    --relabel uniq \
    --tabbedout ASV_infered/ASV_information




