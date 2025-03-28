#!/usr/bin/env nextflow

process SALMON_QUANT {
    conda "rnaseq.yml"
    publishDir "results/salmon/quant", mode: 'copy'
    tag "$sample_id"
    cpus 4

    input:
    path index
    tuple val(sample_id), path(reads)   

    output:
    path "${sample_id}", emit: quant
    script:
    """
    echo "Processing sample $sample_id"
    salmon quant \
    --threads $task.cpus \
    --index $index \
    	--libType A \
    	--validateMappings \
    	--output ${sample_id} \
    	-1 ${reads[0]} \
    	-2 ${reads[1]}

    """

}