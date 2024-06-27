#*******************************************************************************
#*
#*                       Creating Figure 5 of Manuscript                                                                                                                                           
#*    (Kullback-Leibler divergence results - Example 2 on smoking cessation)                                                                                                                                             
#*
#* Author: Loukia M. Spineli 
#* Date: July 2024
#*******************************************************************************


## Download development version of 'rnmamod'
#devtools::install_github("LoukiaSpin/rnmamod")


## Load libraries
list.of.packages <- c("rnmamod", "ggplot2")
lapply(list.of.packages, require, character.only = TRUE); rm(list.of.packages)


## Collect *node-splitting* results from publication (Table 3 in Dias et al., 2010; PMID: 20213715)
# Treatments compared
treat <- c("No contact", "Self-help", "Individual counselling", "Group counselling")

# Baseline arm
base <- rep(1:3, c(3, 2, 1))

# Non-baseline arm
nonbase <- c(2, 3, 4, 3, 4, 4)

# Compared treatments with their names
treat_comp <- mapply(function(x, y) paste(treat[x], "vs", treat[y]), nonbase, base)
  
# Direct results
direct_mean <- c(0.342, 0.845, 1.360, -0.052, 0.676, -0.085)
direct_sd <- c(0.550, 0.254, 0.829, 0.702, 0.698, 0.479)

# Indirect (node-splitting) results
indirect_mean <- c(0.706, 0.673, 1.108, 0.519, 0.511, 1.708)
indirect_sd <- c(0.635, 0.679, 0.539, 0.503, 0.684, 0.893)

# Inconsistency (node-splitting)
incons_mean <- c(-0.365, 0.171, 0.253, -0.571, 0.165, -1.793)
incons_sd <- c(0.840, 0.716, 0.983, 0.853, 0.966, 1.009)

# Collect results
res2 <- data.frame(treat_comp, direct_mean, direct_sd, indirect_mean, indirect_sd, incons_mean, incons_sd)


## Apply framework
# Reference threshold at 0.10 
tiff("./30_Analysis & Results/Figure 5.tiff",
     height = 20,
     width = 35,
     units = "cm",
     compression = "lzw",
     res = 600)
kld_inconsistency_user(dataset = res2, 
                       threshold = 0.10, 
                       level = 0.1,
                       outcome = "Odds ratio (logarithmic scale)")
dev.off()

# Opinion elicitation threshold (tau = 0.08)
kld_inconsistency_user(dataset = res2, 
                       threshold = 0.08, 
                       level = 0.1,
                       outcome = "Odds ratio (logarithmic scale)")

# Empirical threshold based on inconsistency variance (tau = 0.03)
kld_inconsistency_user(dataset = res2, 
                       threshold = 0.03, 
                       level = 0.1,
                       outcome = "Odds ratio (logarithmic scale)")