#!/usr/bin/env nextflow
params.outdir = 'results/fastqc'

process FASTQC {
    conda "rnaseq.yml"
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(sample_id), path(read1), path(read2)

    output:
    path "*_fastqc.zip", emit: zip
    path "*_fastqc.html", emit: html

    script:
    """
    echo "Running FASTQC on $sample_id"
    fastqc $read1 $read2
    """

}