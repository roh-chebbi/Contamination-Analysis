#!/usr/bin/env nextflow

params.outdir = "result/convert_symbol"

process CONVERT_SYMBOLS {
    publishDir params.outdir, mode: "copy"

    input:
    path(abundance_results)

    output:
    path "cibersort_input.txt", emit: cibersort_input


    script:
    """
    ${baseDir}/bin/convert_symbols.R --input ${abundance_results} --output cibersort_input.txt
    """
}