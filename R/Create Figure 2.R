#*******************************************************************************
#*
#*                       Creating Figure 2 of Manuscript                                                                                                                                           
#*                 (Setting the threshold of low inconsistency)                                                                                                                  
#*
#* Author: Loukia M. Spineli 
#* Date: July 2024
#*******************************************************************************


## Load the development version
#devtools::install_github("LoukiaSpin/rnmamod", force = TRUE)


## Load libraries
list.of.packages <- c("rnmamod", "ggpubr")
lapply(list.of.packages, require, character.only = TRUE); rm(list.of.packages)


## Load functions
source("./30_Analysis & Results/Functions/hyperparameters.incons.prior.R")


## Illustrate the 'reference threshold'
# Fictional dataset (log ORs)
dataset <- data.frame(comp = "B vs A", 
                      matrix(c(0.8, 0.15, 0.8, 0.15*sqrt(2), 0, 0.15*sqrt(3)), nrow = 1))
colnames(dataset)[2:7] <- c("dir_mean", "dir_sd", "ind_mean", "ind_sd", "inc_mean", "inc_sd")

# Density plots for direct and indirect effects
p1 <- kld_inconsistency_user(dataset, 
                             threshold = 0.1,
                             outcome = "Odds ratio (logarithmic scale)",
                             show_incons = FALSE,
                             title_name = "Reference threshold",
                             axis_title_size = 12,
                             axis_text_size = 10,
                             strip_text_size = 12,
                             legend_title_size = 12,
                             legend_text_size = 12)


## Illustrate the 'opinion elicitation' threshold
# HN(0, 0.14) is for OR and HN(0, 0.29) for SMD
p2 <- heter_density_plot("halfnormal", 
                         heter_prior1 = c(0, round(sqrt(3) * 0.082, 2)), # for OR
                         heter_prior2 = c(0, round(sqrt(3) * 0.17, 2)),  # for SMD
                         title_name = "Opinion elicitation threshold",
                         axis_title_size = 12,
                         axis_text_size = 10,
                         legend_title_size = 12,
                         legend_text_size = 12)


## Illustrate the prior derivation for inconsistency variance (log OR)
# General healthcare field for log OR: see Table
table_tau2_prior(measure = "OR")

# Generate the LN prior for tau2_omega (median: 0.03)
hyperparameters_incons_prior(mean_tau2 = -2.56,
                             sd_tau2 = 1.74, 
                             mean_scale = 0.10, # one-tenth
                             measure = "OR")

# Density plot of tau2 and tau2_omega
p3 <- heter_density_plot("lognormal", 
                         heter_prior1 = c(-2.56, 1.74), # tau2
                         heter_prior2 = c(-7.14, 2.75), # tau2_omega
                         heter2 = "tau_omega",
                         caption = FALSE,
                         title_name = "Prior derivation for inconsistency variance: General healthcare setting (log OR)",
                         axis_title_size = 12,
                         axis_text_size = 10,
                         legend_title_size = 12,
                         legend_text_size = 12)


## Illustrate the prior derivation for inconsistency variance (SMD)
# General healthcare field for SMD: see Table
table_tau2_prior(measure = "SMD", area = "other") # same hyperparameters, regardless of 'area'

# Generate the location-scale t prior for tau2_omega (median: 0.06)
hyperparameters_incons_prior(mean_tau2 = -3.44,
                             sd_tau2 = 2.59, 
                             mean_scale = 0.10, # one-tenth
                             measure = "SMD")

# Density plot of tau2 and tau2_omega
p4 <- heter_density_plot("logt", 
                         heter_prior1 = c(-3.44, 2.59), # tau2
                         heter_prior2 = c(-5.74, 3.34), # tau2_omega
                         heter2 = "tau_omega",
                         caption = FALSE,
                         title_name = "Prior derivation for inconsistency variance: General healthcare setting (SMD)",
                         axis_title_size = 12,
                         axis_text_size = 10,
                         legend_title_size = 12,
                         legend_text_size = 12)


## Bring all together in a 2x2 panel
tiff("./30_Analysis & Results/Figure 2.tiff",
     height = 20,
     width = 40,
     units = "cm",
     compression = "lzw",
     res = 600)
ggarrange(p1, p2$Density_plots, p3$Density_plots, p4$Density_plots,
          ncol = 2, nrow = 2,
          labels = c("a)", "b)", "c)", "d)"),
          font.label = list(size = 12, color = "black", face = "bold", family = NULL))
dev.off()
