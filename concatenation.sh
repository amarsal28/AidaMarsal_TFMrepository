#!/bin/bash

output_file="./mice.fasta"
> "$output_file"

for file in mice_data_trimmed/*.fasta;
	do
	file_name=$(basename "$file" .fasta)
	sed -e "s/^>.*$/>${file_name};/" "$file" >> "$output_file";
done


