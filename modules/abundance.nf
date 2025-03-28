#!/usr/bin/env nextflow

params.outdir = "results/abundance"

process ABUNDANCE {
    publishDir params.outdir, mode: 'copy'
    
    output:
    path "count_matrix.tsv", emit: counts
    path "tximport_results.rds", emit: abundance_results

    
    script:
    

    """
    ${baseDir}/bin/abundance.R --quant_dir ${baseDir}/results/quant

    
    """
}

