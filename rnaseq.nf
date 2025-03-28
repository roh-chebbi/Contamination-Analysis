#!/usr/bin/env nextflow

// Module INCLUDE statements
include { FASTQC } from './modules/fastqc.nf'
include { SALMON_INDEX } from './modules/salmon_index.nf'
include { SALMON_QUANT } from './modules/salmon_quant.nf'

/*
 * Pipeline parameters
 */
params.transcriptome_path = "/opt/localdata/rchebbi/27jan_boise/salmon/reference_data/Homo_sapiens.GRCh38.cdna.all.fa.gz"
params.index_name = "GRCh38.cdna.all_index"

// Primary input
params.reads = "/opt/localdata/rchebbi/27jan_boise/AMA23638-144297_fastq_091824/KMS12PE-Control-1_S1_R{1,2}_001.fastq.gz"
params.read = "/opt/localdata/rchebbi/27jan_boise/AMA23638-144297_fastq_091824/KMS12PE-Control-1_S1_R1_001.fastq.gz"




workflow {

    // Create input channel
    read_pairs = Channel.fromFilePairs(params.reads, checkIfExists: true)
    // read_singles = read_pairs.flatten().map { id, reads -> reads }
    // index_ch = path(params.index_name)

    // Call processes
    FASTQC(params.read)

    SALMON_INDEX(params.transcriptome_path,params.index_name)

    SALMON_QUANT(SALMON_INDEX.out.index_ch, read_pairs)


}
