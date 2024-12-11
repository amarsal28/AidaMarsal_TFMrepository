#!/bin/bash

# Primer creem un entorn conda, en que directament descarreguem qiime2 
conda env create -n uoc_tfm_qiime2 --file https://data.qiime2.org/distro/amplicon/qiime2-amplicon-2024.2-py38-linux-conda.yml
conda activate uoc_tfm_qiime2

# Nanoplot
pip install NanoPlot

# FastQC
sudo apt update
sudo apt -y install fastqc

# MultiQC
pip install multiqc

# Porechop
conda install bioconda::porechop

# Fastplong
conda install -c bioconda fastplong

# Seqtk
conda install bioconda::seqtk
