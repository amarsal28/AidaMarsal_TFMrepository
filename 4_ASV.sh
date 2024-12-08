# Crear directori dels fastas amb ASVs
mkdir mice_ASV

for fastq in mice_fastq_processed/*.fastq.gz;
do  
    fastq_name=$(basename "$fastq" _trimmed2.fastq.gz)
    
    vsearch --fastx_uniques "$fastq" \
    --fastaout mice_ASV/"$fastq_name".fasta \
    --sizeout --lengthout
done
