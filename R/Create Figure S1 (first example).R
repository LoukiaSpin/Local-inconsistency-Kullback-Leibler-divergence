#*******************************************************************************
#*
#*                       Creating Figure S1 of Manuscript                                                                                                                                           
#*        (Kullback-Leibler divergence for back-calculation - Example 1)                                                                                                                                                 
#*
#* Date: July 2024
#*******************************************************************************


## Download development version of 'rnmamod'
#devtools::install_github("LoukiaSpin/rnmamod")


## Load libraries
library("rnmamod")


## Collect *back-calculation* results from publication (Table 2 in Dias et al., 2010; PMID: 20213715)
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

# Indirect (back-calculation) results
indirect_mean <- c(0.328, -0.246, -0.177, -0.395, -0.166, 0.207, -0.473, -0.144, -0.013, 0.289, 0.141, -0.474, -0.131, 0.170)
indirect_sd <- c(0.233, 0.094, 0.082, 0.120, 0.242, 0.116, 0.108, 0.284, 0.106, 0.182, 0.105, 0.173, 0.280, 0.057)

# Inconsistency (back-calculation) 
incons_mean <- c(-0.331, 0.087, 0.116, -0.271, -0.203, -0.212, -0.068, -0.153, 0.031, -0.176, -0.122, 0.259, 0.276, 1.238)
incons_sd <- c(0.235, 0.106, 0.121, 0.221, 0.571, 0.122, 0.431, 0.448, 0.113, 0.191, 0.124, 0.209, 0.453, 0.420)

# Collect results
res1 <- data.frame(treat_comp, direct_mean, direct_sd, indirect_mean, indirect_sd, incons_mean, incons_sd)


## Apply framework
tiff("./Figures/Figure S1.tiff",
     height = 20,
     width = 35,
     units = "cm",
     compression = "lzw",
     res = 600)
kld_inconsistency_user(dataset = res1, 
                       threshold = 0.64, 
                       level = 0.05,
                       outcome = "Odds ratio (logarithmic scale)")$Density_plot
dev.off()
