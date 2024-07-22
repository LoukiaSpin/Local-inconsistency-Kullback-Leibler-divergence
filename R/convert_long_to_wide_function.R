#*******************************************************************************
#*
#*                Function to turn a gemtc dataset (long format)                                
#*                     into an rnmamod dataset (wide format)                                                                                                                                                                    
#*
#* Author: Loukia M. Spineli
#* Date: July 2024
#*******************************************************************************

convert_long_to_wide <- function (dataset) {

  # Capture the dataset
  data_set <- dataset$data.ab
  
  # Calculate the number of arms per study
  na <- table(data_set$study)
  
  # Add an indicator variable to facilitate reshaping
  data_set$numbers <- unlist(lapply(na, function(x) 1:x))
  
  # Get the desire data format for 'rnmamod'
  dataset_fin <- reshape(data_set, 
                         idvar = "study", 
                         timevar = "numbers", 
                         direction = "wide")
  
  # Rename the columns as required by rnmamod
  colnames(dataset_fin) <-
    if (dim(dataset_fin)[2] == 5) {  # Continuous outcome

      gsub("treatment.", "t",
           gsub("sampleSize.", "n",
                gsub("mean.", "y",
                     gsub("std.dev.", "sd", colnames(dataset_fin)))))
  } else {
    
    gsub("treatment.", "t",
         gsub("sampleSize.", "n",
              gsub("responders.", "r", colnames(dataset_fin))))
  }
  
  # Turn treatment names into numbers
  dataset_fin[, startsWith(colnames(dataset_fin), "t")] <- 
    matrix(unlist(lapply(dataset_fin[, startsWith(colnames(dataset_fin), "t")], 
                         function(x) as.numeric(x))), 
           nrow = dim(dataset_fin)[1], ncol = max(na), byrow = FALSE)
  
  return(dataset_fin)
}
