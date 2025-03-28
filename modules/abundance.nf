#!/usr/bin/env nextflow

process ABUNDANCE {
    conda "rnaseq.yml"
    publishDir "results/abundance", mode: 'copy'
    
    input:
    path gtf
    val quant_info
    
    
    output:
    path "count_matrix.tsv", emit: counts
    path "tximport_results.rds", emit: rds
    
    script:
    """
    def quant_string = quant_info.collect { id, dir -> "$id:$dir" }.join(",")
    ${baseDir}/bin/abundance.R --gtf ${gtf} --quant_info ${quant_info}

    
    """
}

