#*******************************************************************************
#*
#*                       Creating Figure 4 of Manuscript                                                                                                                                                                  
#*    (Contribution to total information loss - Example 1 on thrombolytics)                                                                                                                                                   
#*
#* Author: Loukia M. Spineli
#* Date: July 2024
#*******************************************************************************


## For the moment, please, use the development version of 'rnmamod'
devtools::install_github("LoukiaSpin/rnmamod")


## Load libraries
library("rnmamod")


## Collect *node-splitting* results from publication (Table 2 in Dias et al., 2010; PMID: 20213715)
# Treatments compared
treat <- c("SK", "t-PA", "Acc t-PA", "SK+t-PA", "r-PA", "TNK", "PTCA", "UK", "ASPAC")

# Baseline arm
base <- rep(1:3, c(6, 3, 5))

# Non-baseline arm
nonbase <- c(2, 3, 5, 7, 8, 9, 7, 8, 9, 4, 5, 7, 8, 9)

# Compared treatments with their names
treat_comp <- mapply(function(x, y) paste(treat[x], "vs", treat[y]), nonbase, base)
  
# Direct results
direct_mean <- c(0.000, -0.158, -0.060, -0.666, -0.369, 0.009, -0.545, -0.295, 0.006, 0.126, 0.019, -0.216, 0.143, 1.409)
direct_sd <- c(0.030, 0.048, 0.089, 0.185, 0.518, 0.037, 0.417, 0.347, 0.037, 0.054, 0.066, 0.118, 0.356, 0.415)

# Indirect (node-splitting) results
indirect_mean <- c(0.189, -0.247, -0.175, -0.393, -0.168, 0.424, -0.475, -0.144, 0.471, 0.630, 0.135, -0.477, -0.136, 0.165)
indirect_sd <- c(0.235, 0.092, 0.081, 0.120, 0.244, 0.252, 0.108, 0.290, 0.241, 0.697, 0.101, 0.174, 0.288, 0.057)

# Inconsistency (node-splitting) 
incons_mean <- c(-0.190, 0.088, 0.115, -0.272, -0.207, -0.413, -0.073, -0.155, -0.468, -0.506, -0.116, 0.260, 0.277, 1.239)
incons_sd <- c(0.236, 0.104, 0.121, 0.222, 0.575, 0.253, 0.432, 0.452, 0.241, 0.696, 0.120, 0.211, 0.461, 0.420)

# Collect results
res1 <- data.frame(treat_comp, direct_mean, direct_sd, indirect_mean, indirect_sd, incons_mean, incons_sd)


## Apply framework
tiff("./Figures/Figure 4.tiff",
     height = 20,
     width = 35,
     units = "cm",
     compression = "lzw",
     res = 300)
kld_inconsistency_user(dataset = res1, 
                       threshold = 0.64, 
                       level = 0.05,
                       axis_text_size = 12,
                       outcome = "Odds ratio (logarithmic scale)")$Barplot
dev.off()
