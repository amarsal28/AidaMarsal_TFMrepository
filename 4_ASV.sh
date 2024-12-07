# Crear directori dels fastas amb ASVs
mkdir mice_ASV

for fastq in mice_fastq_processed/*.fastq.gz;
do  
    fastq_name = $(basename "$fastq".fastq.gz)
    vsearch --fastx_uniques ./mice_fastq_processed/"$fastq".fastq.gz \
    --fastaout mice_ASV/"$fastq_name".fasta \
    --sizeout --lengthout
done