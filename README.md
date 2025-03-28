# Contamination-Analysis

## Overview

This Nextflow pipeline is designed for Contamination Analysis by cell type enrichment of bulk RNA-seq samples. It incorporates quality control, quantification, gene expression abundance calculation and cell type deconvolution. 

## Workflow

- Quality control of raw sequencing data using FastQC (can handle both single-end and paired-end reads)
- Aggregated quality reports with MultiQC
- Transcriptome indexing with Salmon
- Transcript quantification using Salmon
- Abundance estimation using tximport
- Gene symbol conversion
- Cell type deconvolution with CIBERSORT

<img width="390" alt="image" src="https://github.com/user-attachments/assets/f71d2014-cb42-4f43-abd3-3e8bee50465c" />



## Prerequisites

- Nextflow
- Conda
- Input data:
  - Paired-end FASTQ files
  - Reference transcriptome (FASTA)
  - GTF annotation file

## Usage

1. Clone this repository:

`git clone https://github.com/yourusername/rna-seq-pipeline.git](https://github.com/roh-chebbi/Contamination-Analysis.git
cd Contamination_Analysis`

2. Run the pipeline:

`nextflow run main.nf -profile conda`


## Pipeline Structure

- `main.nf`: Main pipeline script
- `modules/`: Directory containing individual process modules
- `fastqc.nf`: FastQC process
- `multiqc.nf`: MultiQC process
- `salmon_index.nf`: Salmon indexing process
- `salmon_quant.nf`: Salmon quantification process
- `abundance.nf`: Abundance estimation process 
- `convert_symbols.nf`: Gene symbol conversion process 
- `cibersort.nf`: CIBERSORT analysis process
- `bin/`: Directory containing custom R scripts
- `abundance.R`: summarize transcript-level using tximport
- `convert_symbols.R`: converts ENSEMBLE IDs to gene symbols using org.Hs.eg.db
- `cibersort.R`: calculates cell type enrichment via cell type deconvultion using CIBERSORT

## Input

- `params.input_csv`: CSV file containing a list of sample IDs and path(s) to FASTQ files
- `params.transcriptome_path`: Path to the reference transcriptome FASTA file
- `params.gtf`: Path to the GTF annotation file

## Output

- FastQC reports for each sample
- MultiQC report summarizing all QC metrics
- Salmon index
- Salmon quantification results for each sample
- Abundance estimation using tximport
- Conversion of ENSEMBLE IDs to gene symbols
- Cell type enrichment using CIBERSORT

