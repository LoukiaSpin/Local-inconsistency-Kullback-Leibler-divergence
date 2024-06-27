#*******************************************************************************
#*
#*                       Creating Figure 6 of Manuscript                                                                                                                                           
#*   (Kullback-Leibler divergence results - Example 3 on Parkinson's disease)                                                                                                                                                
#*
#* Author: Loukia M. Spineli 
#* Date: July 2024
#*******************************************************************************


## Download development version of 'rnmamod'
#devtools::install_github("LoukiaSpin/rnmamod", force = TRUE)


## Load libraries ----
list.of.packages <- c("netmeta", "rnmamod")
lapply(list.of.packages, require, character.only = TRUE); rm(list.of.packages)


## Get dataset from netmeta
data(Franchini2012)


## Transform data from arm-based format to contrast-based format (taken from netmeta)
data_set <- pairwise(list(Treatment1, Treatment2, Treatment3),
                     n = list(n1, n2, n3),
                     mean = list(y1, y2, y3), 
                     sd = list(sd1, sd2, sd3),
                     data = Franchini2012, 
                     studlab = Study)


## Conduct network meta-analysis
net <- netmeta(data_set,
               sm = "SMD", 
               common = FALSE,
               random = TRUE)


## Conduct back-calculation
back_calc <- netsplit(net,
                      method = "Back-calculation",
                      reference.group = "Placebo",
                      common = FALSE,
                      random = TRUE)


## Create Table 1
# Get results from 'netsplit'
res_tab0 <- data.frame(dir = back_calc$direct.random[, c(1:2, 4:5)],
                       ind = back_calc$indirect.random[, c(2, 4:5)],
                       dif = back_calc$compare.random[, c(2, 4:5)])

# Keep only the target comparisons 
res_tab1 <- subset(res_tab0, !is.na(dif.TE))

# Sort in increasing order of KLD (This is Table 1)
res_tab1[order(c(0.59, 0.06, 0.62, 1.33, 0.13)), ]


## Inconsistency interpretation framework
# Reference threshold at 0.10 
kld_inconsistency(node = back_calc,
                  threshold = 0.10,
                  outcome = "Standardised mean difference")

# Opinion elicitation threshold (tau = 0.17)
tiff("./30_Analysis & Results/Figure 6.tiff",
     height = 20,
     width = 35,
     units = "cm",
     compression = "lzw",
     res = 600)
kld_inconsistency(node = back_calc,
                  threshold = 0.17,
                  outcome = "Standardised mean difference")
dev.off()

# Empirical threshold based on inconsistency variance (tau = 0.07)
kld_inconsistency(node = back_calc,
                  threshold = 0.07,
                  outcome = "Standardised mean difference")

