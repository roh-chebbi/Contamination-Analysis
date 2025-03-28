#!/usr/bin/env nextflow

process SALMON_INDEX {
    conda "rnaseq.yml"
    publishDir "results/salmon", mode: 'copy'
    input:
    path transcriptome
    val index_name

    output:
    path "$index_name", emit: index_ch
    script:
    """
    salmon index -t ${transcriptome}  -i ${index_name} -k31
    """
}