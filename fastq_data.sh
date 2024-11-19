# Descomprimir l'arxiu (si no està en el directori en que estem treballant, caldrà indicar en quin es troba l'arxiu)
unrar x mice_fastq.rar
mv 'Archivos fastq_23OT00046' mice_data

# Modifiquem el nom dels arxius fastq (perque no tinguin espais) i els comprimim en .gz
for doc in mice_data/*.fastq; do
    name=$(echo "$doc" | tr ' \-' '_')
    mv "$doc" "$name"
    gzip "$name"
done

# Convertim els arxius FASTQ en FASTA - Ja no serà necessari perque ho hem passat a FASTA en el quality filtering. 
#mkdir mice_data_fasta
#for file in mice_data/*.fastq.gz; do
    #file_name=$(basename "$file" .fastq.gz)
    #zcat "$file" | awk 'NR%4==1 {print ">" substr($0, 2)} NR%4==2 {print}' > "mice_data_fasta/${file_name}.fasta"
#done




