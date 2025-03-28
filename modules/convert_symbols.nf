#!/usr/bin/env nextflow

process CONVERT_SYMBOLS {

    script:
    """
    ${baseDir}/bin/convert_symbols.R
    """
}