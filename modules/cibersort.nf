#!/bin/usr/env nextflow

process CIBERSORT {

    script:
    """
    ${baseDir}/bin/cibersort.R
    """
}