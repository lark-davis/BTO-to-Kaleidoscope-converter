# BTO-to-Kaleidoscope-converter v1.4

## DESCRIPTION 
This script converts a BTO Acoustic Pipeline results file (.csv) to a file that can be opened and analysed in Kaleidoscope.

## TO RUN
Place your BTO Pipeline results file (.csv), this script and the sound files that were analysed by BTO Pipeline in the same folder. Edit line 35 in the script to be the name of your BTO results file. Run the script. A file with your converted results will be created in the working directory, called Converted_BTO_results.csv. Open this file in Kaleidoscope as you would a normal results file (meta.csv): File > Open Results. 

## COLUMNS IN CONVERTED FILE

INDIR

IN FILE*

DATE

DATE-12

TIME

LATITUDE

LONGITUDE

Species group

Call type

NOTES

AUTO ID

Probability

MANUAL ID

REVIEW USERID

INPATHMD5

## NOTE
If you can't see these columns in Kaleidoscope, choose to show them in File > Edit columns. 

## AUTHOR
Lark Davis
lark.isadora.davis@gmail.com
