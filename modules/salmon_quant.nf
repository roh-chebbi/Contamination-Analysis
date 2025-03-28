#!/usr/bin/env nextflow

params.outdir = 'results/quant'

process SALMON_QUANT {
    conda "rnaseq.yml"
    publishDir params.outdir, mode: 'copy'
    cpus 4

    input:
    path index
    tuple val(sample_id), path(read1), path(read2)   

    output:
    path "${sample_id}", emit: quant_ch
    script:
    """
    echo "Processing sample $sample_id"
    salmon quant \
    --threads $task.cpus \
    --index $index \
    	--libType A \
    	--validateMappings \
    	--output ${sample_id} \
    	-1 ${read1} \
    	-2 ${read2}

    """

}