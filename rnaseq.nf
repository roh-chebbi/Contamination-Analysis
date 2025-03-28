#!/usr/bin/env nextflow

include { FASTQC } from './modules/fastqc.nf'
include { MULTIQC } from './modules/multiqc.nf'
include { SALMON_INDEX } from './modules/salmon_index.nf'
include { SALMON_QUANT } from './modules/salmon_quant.nf'
include { ABUNDANCE } from './modules/abundance.nf'
include { CONVERT_SYMBOLS } from './modules/convert_symbols.nf'
include { CIBERSORT } from './modules/cibersort.nf'


params.transcriptome_path = "/opt/localdata/rchebbi/27jan_boise/salmon/reference_data/Homo_sapiens.GRCh38.cdna.all.fa.gz"
params.index_name = "GRCh38.cdna.all_index"
params.gtf = "/opt/localdata/rchebbi/27jan_boise/salmon/reference_data/Homo_sapiens.GRCh38.113.gtf.gz"
params.input_csv = "data/SampleSheet.csv"



workflow {


    reads_ch = Channel.fromPath(params.input_csv)
    .splitCsv(header: true)
    .map { row -> tuple(row.sample_id,
    file(row.fastq_1), file(row.fastq_2))
        }

    FASTQC(reads_ch)

    MULTIQC(FASTQC.out.html.mix(FASTQC.out.zip).collect())

    SALMON_INDEX(params.transcriptome_path,params.index_name)

    SALMON_QUANT(SALMON_INDEX.out.index_ch, reads_ch)

    ABUNDANCE()

    CONVERT_SYMBOLS(ABUNDANCE.out.abundance_results)

    CIBERSORT(CONVERT_SYMBOLS.out.cibersort_input)



}
