#*******************************************************************************
#*
#*                       Creating Figure 1 of Manuscript                                                                                                                                           
#*                   (Networks of the investigated examples)                                                                               
#*
#* Author: Loukia M. Spineli 
#* Date: July 2024
#*******************************************************************************


## Load libraries
list.of.packages <- c("rnmamod", "gemtc", "stringr")
lapply(list.of.packages, require, character.only = TRUE); rm(list.of.packages)


## Load function
source("./R/convert_long_to_wide_function.R")


## Load datasets
# Example 1 - Thrombolytics network
data("thrombolytic")

# Example 2 - Smoking cessation network
data("smoking")

# Example 3 - Parkinson network
data("parkinson")


## Panel of three networks
tiff("./Figures/Figure 1.tiff",
     height = 20,
     width = 37,
     units = "cm",
     compression = "lzw",
     res = 600)
layout(matrix(c(1, 2, 3, 3), 2, 2, byrow = TRUE))

par(mai = c(0.2, 2, 0.2, 0.2))
netplot(data = convert_long_to_wide(dataset = thrombolytic),
        drug_names = thrombolytic$treatments$id,
        show_multi = TRUE,
        node_frame_color = "pink",
        node_frame_width = 2,
        node_color = "pink",
        node_label_dist = 0,
        node_label_cex = 1.3,
        edge_color = "grey",
        edge_label_cex = 1.2)
mtext(paste("a)  Thrombolytics"), 3, line = 0, cex = 1.1, font = 2)

par(mai = c(0.2, 0.2, 0.2, 2))
netplot(data = convert_long_to_wide(dataset = smoking),
        drug_names = str_to_lower(smoking$treatments$description),
        show_multi = TRUE,
        node_frame_color = "salmon",
        node_frame_width = 2,
        node_color = "salmon",
        node_label_cex = 1.3,
        edge_color = "grey",
        edge_label_cex = 1.2)
mtext(paste("b)  Smoking cessation"), 3, line = 0, cex = 1.1, font = 2)

par(mar = c(0.2, 14, 0.2, 14))
netplot(data = convert_long_to_wide(dataset = parkinson),
        drug_names = c("placebo", "ropinirole", "pramipexole", "bromocriptine", "cabergoline"),
        show_multi = TRUE,
        node_frame_color = "plum1",
        node_frame_width = 2,
        node_color = "plum1",
        node_label_cex = 1.3,
        edge_color = "grey55",
        edge_label_cex = 1.2)
mtext(paste("c)  Parkinson's disease"), 3, line = 0, cex = 1.1, font = 2)
dev.off()
