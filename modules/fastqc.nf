#!/usr/bin/env nextflow

process FASTQC {
    conda "rnaseq.yml"
    publishDir "results/fastqc", mode: 'copy'

    input:
    path reads

    output:
    path "${reads.simpleName}_fastqc.zip", emit: zip
    path "${reads.simpleName}_fastqc.html", emit: html

    script:
    """
    echo "Running FASTQC on $reads"
    fastqc $reads
    """

}