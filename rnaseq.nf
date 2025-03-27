#!/usr/bin/env nextflow

// Module INCLUDE statements
include { FASTQC } from './modules/fastqc.nf'
include { SALMON_INDEX } from './modules/salmon_index.nf'

/*
 * Pipeline parameters
 */
params.transcriptome_path = "/opt/localdata/rchebbi/27jan_boise/salmon/reference_data/Homo_sapiens.GRCh38.cdna.all.fa.gz"
params.index_name = "GRCh38.cdna.all_index"

// Primary input
params.reads = "/opt/localdata/rchebbi/27jan_boise/AMA23638-144297_fastq_091824/KMS12PE-Control-1_S1_R1_001.fastq.gz"




workflow {

    // Create input channel
    reads_ch = channel.fromPath(params.reads)

    // Call processes
    FASTQC(reads_ch)

    SALMON_INDEX(params.transcriptome_path,params.index_name)



}
