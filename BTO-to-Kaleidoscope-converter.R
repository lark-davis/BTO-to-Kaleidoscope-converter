#############################################################
#
# DESCRIPTION: This script converts a BTO-results file (.csv) to a file that can be opened and analysed in Kaleidoscope.
#
# TO RUN: Place your BTO results file (.csv), this script and the sound files that were analysed by BTO in the same folder. Run this script from that location. A file with your converted results will be created in the working directory, called Converted_BTO_results.csv. Open this file in Kaleidoscope as you would a normal results file (meta.csv): File > Open Results. 
# 
# NOTE: If you can't see all the columns in Kaleidoscope, choose to show them in File > Edit columns. 
#
# AUTHOR: Lark Davis, lark.isadora.davis@gmail.com
# REVISION HISTORY: v 1.4
# 250908 DATE-12 added
# 250910 removed duplicate files from output, removed dbplyr and added dplyr package.
# 250926 Changed column names to match BTO
# 251117 Changed line 46 to ORIGINAL.FILE.NAME from RECORDING.FILE.NAME for BatLogger. BTO creates unique file names from metadata for BatLogger, which led to duplicates.
#
#############################################################

# Install required packages. This is only necessary the first time you run the script and does need to be run every time.
install.packages("this.path")
install.packages("dplyr")
install.packages("tibble")

# Load package libraries. This needs to be done every time you start a new RStudio session. 
library(this.path)
library(dplyr, warn.conflicts = FALSE)
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
  
  # Remove duplicate rows
  distinct(ORIGINAL.FILE.NAME, .keep_all = TRUE) %>%
  
  # Remove unnecessary columns from BTO
  select(-c('RECORDING.FILE.NAME', 'ORIGINAL.FILE.PART', 'SCIENTIFIC.NAME' ,'ENGLISH.NAME', 'PROJECT.NAME', 'UPLOAD.KEY', 'USER.ID', 'CLASSIFIER.NAME', 'WARNINGS' )) %>%
  
  # Rename existing columns to match Kaleidoscope
  rename('IN FILE*' = 'ORIGINAL.FILE.NAME', 'DATE' = 'ACTUAL.DATE', 'DATE-12' = 'SURVEY.DATE', 'AUTO ID' = 'SPECIES', 'Species group' = 'SPECIES.GROUP', 'Call type' = 'CALL.TYPE','Probability' = 'PROBABILITY', 'NOTES' = 'BATCH.NAME' ) %>%
  
  # Add and move columns required by Kaleidoscope
  mutate('INDIR'= file_location,
         .before='IN FILE*') %>%
  
  relocate('DATE',
           .after='IN FILE*') %>%
  
  relocate('DATE-12',
           .after='DATE') %>%
  
  relocate('TIME',
           .after='DATE') %>%
  
  relocate('Species group',
           .after='LONGITUDE') %>%
  
  relocate('Call type',
           .after='Species group') %>%
  
  relocate('NOTES',
           .after='Call type') %>%
  
  relocate('AUTO ID',
           .after='NOTES') %>%
  
  relocate('Probability',
           .after='AUTO ID') %>%
  
  mutate('MANUAL ID'=c(''),
         .after='Probability') %>%
  
  mutate('REVIEW USERID'=c(''),
         .after='MANUAL ID') %>%
  
  mutate('INPATHMD5'=c(''),
         .after='REVIEW USERID')



# Create new meta-file for Kaleidoscope and place it in the same folder as this script
write.csv(converted_file, "Converted_BTO_results.csv", row.names = FALSE)
print("Your results are now ready, they can be found in the file 'Converted_BTO_results.csv' in the working directory. Happy analysing!")



