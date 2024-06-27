#*******************************************************************************
#*
#*                       Creating Figure 3 of Manuscript                                                                                                                                           
#*         (Empirical thresholds of low inconsistency for the examples)                                                                                                                                   
#*
#* Author: Loukia M. Spineli 
#* Date: July 2024
#*******************************************************************************


## Load the development version
#devtools::install_github("LoukiaSpin/rnmamod", force = TRUE)


## Load libraries
list.of.packages <- c("rnmamod", "ggpubr")
lapply(list.of.packages, require, character.only = TRUE); rm(list.of.packages)


## Example 1 (thrombolytics networks)
# Outcome type: 'all-cause mortality', Interventions type: 'pharma vs non-pharma' (angioplasty)
table_tau2_prior(measure = "OR") # Find the distribution in the Table

# Derive the log-normal distribution for tau2_omega (median: 0.03)
inconsistency_variance_prior(mean_tau2 = -2.92,
                             sd_tau2 = 1.02, 
                             mean_scale = 0.10, # one-tenth
                             measure = "OR")

# Density plot of tau2 and tau2_omega
p1 <- heter_density_plot("lognormal", 
                         heter_prior1 = c(-2.92, 1.02), # tau2
                         heter_prior2 = c(-7.31, 2.28), # tau2_omega
                         heter2 = "tau_omega",
                         caption = FALSE,
                         title_name = "All-cause mortality for pharmacological vs. non-pharmacological",
                         axis_title_size = 12,
                         axis_text_size = 10,
                         legend_title_size = 12,
                         legend_text_size = 12)


## Example 2 (smoking cessation)
# Outcome type: 'signs/symptoms reflecting continuation/end of condition', Interventions type: 'non-pharma vs pbo/ctrl' 
table_tau2_prior(measure = "OR") # Find the distribution in the Table

# Derive the log-normal distribution for tau2_omega (median: 0.03)
inconsistency_variance_prior(mean_tau2 = -2.28,
                             sd_tau2 = 1.71, 
                             mean_scale = 0.10, # one-tenth
                             measure = "OR")

# Density plot of tau2 and tau2_omega
p2 <- heter_density_plot("lognormal", 
                         heter_prior1 = c(-2.28, 1.71), # tau2
                         heter_prior2 = c(-6.86, 2.73), # tau2_omega
                         heter2 = "tau_omega",
                         caption = FALSE,
                         title_name = "Signs reflecting end of condition for non-pharmacological vs. placebo/control",
                         axis_title_size = 12,
                         axis_text_size = 10,
                         legend_title_size = 12,
                         legend_text_size = 12)


## Example 3 (Parkinson's disease)
# Outcome type: 'signs/symptoms reflecting continuation/end of condition', Interventions type: 'pharma vs pbo/ctrl' 
table_tau2_prior(measure = "SMD", area = "other") # Find the distribution in the Table

# Derive the location-scale t prior for log tau2_omega (median: 0.07)
inconsistency_variance_prior(mean_tau2 = -3.00,
                             sd_tau2 = 2.50, 
                             mean_scale = 0.10, # one-tenth
                             measure = "SMD")

# Density plot of log tau2 and log tau2_omega
p3 <- heter_density_plot("logt", 
                         heter_prior1 = c(-3.00, 2.50), # tau2
                         heter_prior2 = c(-5.30, 3.23), # tau2_omega
                         heter2 = "tau_omega",
                         caption = FALSE,
                         title_name = "Signs reflecting continuation of condition for pharmacological vs. placebo/control",
                         axis_title_size = 12,
                         axis_text_size = 10,
                         legend_title_size = 12,
                         legend_text_size = 12)


## Bring all together in a 2x2 panel
tiff("./Figures/Figure 3.tiff",
     height = 20,
     width = 35,
     units = "cm",
     compression = "lzw",
     res = 600)
ggarrange(p1$Density_plots, p2$Density_plots, p3$Density_plots,
          ncol = 2, nrow = 2,
          labels = c("a)", "b)", "c)"),
          font.label = list(size = 12, color = "black", face = "bold", family = NULL))
dev.off()
