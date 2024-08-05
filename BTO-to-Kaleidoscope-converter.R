#############################################################
#
# DESCRIPTION: This script converts a BTO-results file (.csv) to a file that can be opened and analysed in Kaleidoscope.
#
# TO RUN: Place your BTO results file (.csv), this script and the sound files that were analysed by BTO in the same folder. Run this script from that location. A file with your converted results will be created in the working directory, called Converted_BTO_results.csv. Open this file in Kaleidoscope as you would a normal results file (meta.csv): File > Open Results. 
# 
# COLUMN MAPPING: Kaleidoscope uses fixed column header-names that cannot be changed in the free version. Therefore this script re-uses those pre-existing column names and maps them to BTO's column names as follows: 
# 'IN FILE*' = 'ORIGINAL.FILE.NAME', 'DATE' = 'ACTUAL.DATE', 'AUTO ID' = 'SPECIES', 'FIRMWARE' = 'SPECIES.GROUP', 'PREFIX' = 'CALL.TYPE','MATCH RATIO' = 'PROBABILITY', 'NOTES' = 'BATCH.NAME'
# NOTE: If you can't see these columns in Kaleidoscope, choose to show them in File > Edit columns. 
#
# AUTHOR: Lark Davis, lark.isadora.davis@gmail.com
# REVISION HISTORY: v 1.0
#
#############################################################

# Install required packages. This is only necessary the first time you run the script and does need to be run every time.
install.packages("this.path")
install.packages("dbplyr")
install.packages("tibble")

# Load package libraries. This needs to be done every time you start a new RStudio session. 
library(this.path)
library(dbplyr)
library(tibble)

# Set the working directory to the current folder where this script is located.
setwd(this.path::here())

####### IMPORTANT! Fill in name of your downloaded BTO results file to be analysed below. 
####### The BTO file needs to be in the same folder as this script.
####### The sound files, original BTO results file and this script should all be in the same folder.

file <- read.csv("Your_BTO_results_file_name_here.csv")

#############################################################

# Get the current folder path for INDIR column
file_location <- this.path::here()

# Build new data frame
converted_file <- file %>%
  
  # Remove unnecessary columns from BTO
  dplyr::select(-c('RECORDING.FILE.NAME', 'ORIGINAL.FILE.PART', 'SCIENTIFIC.NAME' ,'ENGLISH.NAME', 'PROJECT.NAME', 'UPLOAD.KEY', 'USER.ID', 'CLASSIFIER.NAME', 'SURVEY.DATE', 'WARNINGS' )) %>%
  
  # Rename existing columns to match Kaleidoscope
  dplyr::rename('IN FILE*' = 'ORIGINAL.FILE.NAME', 'DATE' = 'ACTUAL.DATE', 'AUTO ID' = 'SPECIES', 'FIRMWARE' = 'SPECIES.GROUP', 'PREFIX' = 'CALL.TYPE','MATCH RATIO' = 'PROBABILITY', 'NOTES' = 'BATCH.NAME' ) %>%
  
  # Add and move columns required by Kaleidoscope
  dplyr::mutate('INDIR'= file_location,
                .before='IN FILE*') %>%
  
  dplyr::relocate('DATE',
                .after='IN FILE*') %>%
  
  dplyr::relocate('TIME',
                  .after='DATE') %>%
  
  dplyr::relocate('FIRMWARE',
                .after='LONGITUDE') %>%
  
  dplyr::relocate('PREFIX',
                  .after='FIRMWARE') %>%
  
  dplyr::relocate('NOTES',
                .after='PREFIX') %>%
  
  dplyr::relocate('AUTO ID',
                  .after='NOTES') %>%
  
  dplyr::relocate('MATCH RATIO',
                  .after='AUTO ID') %>%
  
  dplyr::mutate('MANUAL ID'=c(''),
                .after='MATCH RATIO') %>%
  
  dplyr::mutate('REVIEW USERID'=c(''),
                .after='MANUAL ID') %>%

  dplyr::mutate('INPATHMD5'=c(''),
                .after='REVIEW USERID')

# Create new meta-file for Kaleidoscope and place it in the same folder as this script
write.csv(converted_file, "Converted_BTO_results.csv", row.names = FALSE)
print("Your results are now ready, they can be found in the file 'Converted_BTO_results.csv' in the working directory. Happy analysing!")


  
