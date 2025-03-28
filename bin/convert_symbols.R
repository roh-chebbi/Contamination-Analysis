#!/usr/lib64/R/bin/Rscript
.libPaths("/home/rchebbi/R/x86_64-redhat-linux-gnu-library/4.4")

library(dplyr)
library(tibble)
library(stringr)
library(org.Hs.eg.db)
library(AnnotationDbi)

txi.salmon <- readRDS("/opt/localdata/rchebbi/27jan_boise/Contamination_Analysis/bin/tximport_results.rds")
gene_expression <- txi.salmon$abundance
#filter out genes with zero expression
gene_expression <- gene_expression[rowSums(gene_expression) > 1, ]

# Extract Ensembl gene IDs
ensembl_ids <- rownames(gene_expression) %>%
  tibble::enframe() %>%
  mutate(ENSEMBL =stringr::str_replace(value, "\\.[0-9]+", ""))

# Convert Ensembl IDs to gene symbols
gene_symbols <- mapIds(org.Hs.eg.db, 
                       keys = ensembl_ids$ENSEMBL,
                       column = "SYMBOL",
                       keytype = "ENSEMBL",
                       multiVals = "first")

# Create a new data frame with gene symbols
gene_expression_named <- data.frame(gene_symbol = gene_symbols,
                                    gene_expression,
                                    row.names = NULL)

# Remove rows with NA gene symbols and aggregate duplicate gene symbols
gene_expression_final <- gene_expression_named %>%
  filter(!is.na(gene_symbol)) %>%
  group_by(gene_symbol) %>%
  summarize(across(everything(), mean)) %>%
  column_to_rownames("gene_symbol")


write.table(gene_expression_final, file = "cibersort_input.txt", 
            sep = "\t", quote = FALSE, col.names = TRUE)