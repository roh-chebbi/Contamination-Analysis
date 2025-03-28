#!/usr/bin/env nextflow

params.outdir = 'results/multiqc'

process MULTIQC {

    conda "rnaseq.yml"
    publishDir params.outdir, mode: 'copy'

    input:
    path '*'

    output:
    path "multiqc_report.html", emit: report
    path "multiqc_data", emit: data

    script:
    """
    multiqc . 
    """
}
