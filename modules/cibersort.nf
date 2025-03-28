#!/bin/usr/env nextflow
params.outdir = "results/cibersort"

process CIBERSORT {

    input:
    path cibersort_input

    script:
    """
    ${baseDir}/bin/cibersort.R
    """
}