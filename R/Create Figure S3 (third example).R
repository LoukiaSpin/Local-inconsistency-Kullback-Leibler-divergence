#*******************************************************************************
#*
#*                       Creating Figure S3 of Manuscript                                                                                                                                           
#*  (Contribution to total information loss - Example 3 on Parkinson's disease)                                                                                                                                                 
#*
#* Author: Loukia M. Spineli
#* Date: July 2024
#*******************************************************************************


## For the moment, please, use the development version of 'rnmamod'
devtools::install_github("LoukiaSpin/rnmamod", force = TRUE)


## Load libraries ----
list.of.packages <- c("gemtc", "rnmamod")
lapply(list.of.packages, require, character.only = TRUE); rm(list.of.packages)


## Node-splitting approach (read results from file instead of running)
result.ns <- readRDS(system.file('extdata/parkinson.ns.rds', package = 'gemtc'))


## Inconsistency interpretation framework
tiff("./Figures/Figure S3.tiff",
     height = 20,
     width = 35,
     units = "cm",
     compression = "lzw",
     res = 600)
kld_inconsistency(node = result.ns,
                  threshold = 0.64,
                  outcome = "Mean difference")$Barplot
dev.off()
