#!/usr/lib64/R/bin/Rscript
.libPaths("/home/rchebbi/R/x86_64-redhat-linux-gnu-library/4.4")

# tximport_standalone.R
library(argparse)
library(tximport)
library(GenomicFeatures)

# Set up command-line arguments
parser <- ArgumentParser(description='TXimport count processing')
parser$add_argument('--gtf', help='Path to GTF file')
parser$add_argument('--quant_dir', required=TRUE, help='Path to Salmon Quant Output')
parser$add_argument('--output_counts', default='count_matrix.tsv', 
                   help='Output count matrix')
parser$add_argument('--output_rds', default='tximport_results.rds', 
                   help='Output RDS object')
parser$add_argument('--custom_txdb_path', default='/opt/localdata/rchebbi/27jan_boise/salmon/reference_data/tx2gene.txt',help='Custom tx db path')
args <- parser$parse_args()

# Generate tx2gene mapping
#txdb <- makeTxDbFromGFF(args$gtf)
#k <- keys(txdb, keytype = "TXNAME")
#tx2gene <- AnnotationDbi::select(txdb, keys = k, keytype = "TXNAME", columns = "GENEID")

tx2gene <- read.table(args$custom_txdb_path, header = FALSE, sep = "\t", 
                      stringsAsFactors = FALSE, quote = "", 
                      fill = TRUE, col.names = c("TXNAME", "GENEID","GENENAME"))

# Process Salmon outputs
samples <- list.dirs(args$quant_dir, recursive=FALSE, full.names=FALSE)
files <- file.path(args$quant_dir, samples, "quant.sf")
names(files) <- gsub("-", ".", samples)

# Import counts
txi <- tximport(files, type="salmon", tx2gene=tx2gene, countsFromAbundance="lengthScaledTPM")

# Save outputs
write.table(txi$counts, args$output_counts, sep="\t", quote=FALSE)
saveRDS(txi, args$output_rds)
