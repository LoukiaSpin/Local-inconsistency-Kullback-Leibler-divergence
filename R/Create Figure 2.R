#*******************************************************************************
#*
#*                       Creating Figure 2 of Manuscript                                                                                                                                           
#*              (Setting the threshold of acceptable inconsistency)                                                                                                                                
#*
#* Author: Loukia M. Spineli 
#* Date: July 2024
#*******************************************************************************


## Load the development version
#devtools::install_github("LoukiaSpin/rnmamod", force = TRUE)


## Load libraries
list.of.packages <- c("rnmamod", "ggpubr")
lapply(list.of.packages, require, character.only = TRUE); rm(list.of.packages)


## Fictional dataset (log ORs)
dataset <- function (mean_dir = 1.17, mean_ind = 0.0, tau) {

  data_set <- data.frame(comp = "B vs A", 
                         matrix(c(mean_dir * tau, tau, 
                                  mean_ind, sqrt(2) * tau, 
                                  mean_dir * tau - mean_ind, sqrt(3) * tau), 
                                nrow = 1))
  colnames(data_set)[2:7] <- c("dir_mean", "dir_sd", "ind_mean", "ind_sd", "inc_mean", "inc_sd")
  
  return(data_set)
}
  

## Assuming *inconsistency* and *low* statistical heterogeneity 
p1 <- kld_inconsistency_user(dataset(tau = 0.1), 
                             outcome = "Odds ratio (logarithmic scale)",
                             show_incons = FALSE,
                             title_name = "Inconsistency with low statistical heterogeneity (\u03C4 = 0.10)",
                             axis_title_size = 12,
                             axis_text_size = 10,
                             strip_text_size = 12,
                             legend_title_size = 12,
                             legend_text_size = 12)$Density_plot


## Assuming *consistency* and *low* statistical heterogeneity 
p2 <- kld_inconsistency_user(dataset(mean_ind = 1.17 * 0.1, tau = 0.1), 
                             outcome = "Odds ratio (logarithmic scale)",
                             show_incons = FALSE,
                             y_axis_name = FALSE,
                             title_name = "Consistency with low statistical heterogeneity (\u03C4 = 0.10)",
                             axis_title_size = 12,
                             axis_text_size = 10,
                             strip_text_size = 12,
                             legend_title_size = 12,
                             legend_text_size = 12)$Density_plot


## Bring all together in a 1x2 panel
tiff("./Figures/Figure 2.tiff",
     height = 20,
     width = 40,
     units = "cm",
     compression = "lzw",
     res = 600)
ggarrange(p1, p2,
          ncol = 2, nrow = 1,
          labels = c("a)", "b)"),
          font.label = list(size = 12, color = "black", face = "bold", family = NULL),
          common.legend = TRUE,
          legend = "bottom")
dev.off()
