#!/usr/bin/env nextflow

process ABUNDANCE {
    conda "rnaseq.yml"
    publishDir "results/abundance", mode: 'copy'
    
    //input:
    //path salmon_quant_dir
    //path gtf
    
    //output:
    //path "count_matrix.tsv", emit: counts
    //path "tximport_results.rds", emit: rds
    
    script:
    """
    ${baseDir}/bin/abundance.R --gtf /opt/localdata/rchebbi/27jan_boise/salmon/reference_data/Homo_sapiens.GRCh38.113.gtf.gz --quant_dir /opt/localdata/rchebbi/27jan_boise/salmon/quant

    
    """
}

