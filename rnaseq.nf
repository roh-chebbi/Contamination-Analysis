#!/usr/bin/env nextflow

// Module INCLUDE statements
include { FASTQC } from './modules/fastqc.nf'


/*
 * Pipeline parameters
 */


// Primary input
params.reads = "/opt/localdata/rchebbi/27jan_boise/AMA23638-144297_fastq_091824/KMS12PE-Control-1_S1_R1_001.fastq.gz"




workflow {

    // Create input channel
    reads_ch = channel.fromPath(params.reads)

    // Call processes
    FASTQC(reads_ch)


}
