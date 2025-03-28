#!/usr/lib64/R/bin/Rscript
.libPaths("/home/rchebbi/R/x86_64-redhat-linux-gnu-library/4.4")

library(CIBERSORT)

sig_matrix <- system.file("extdata", "LM22.txt", package = "CIBERSORT")

input_file <- "/opt/localdata/rchebbi/27jan_boise/Contamination_Analysis/bin/cibersort_input.txt"

results <- cibersort(sig_matrix, input_file, QN =TRUE)

write.table(results, file = "cibersort_results.txt", 
            sep = "\t", quote = FALSE, col.names = TRUE)
