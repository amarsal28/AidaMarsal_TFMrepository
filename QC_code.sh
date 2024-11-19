mkdir QC_mice_data
fastqc -o QC_mice_data mice_data_trimmed/*.fasta

# Per generar un document amb MultiQC, primer l'hem d'instal·lar (primer Python, pq és un paquet fet amb python, i després ja el paquet en si):
#apt install python3-pip   # Instal·lació Python
#pip install multiqc  # Instal·lació MultiQC

# Ara generem el informe:
multiqc ./QC_mice_data


