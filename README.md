# BTO-to-Kaleidoscope-converter

## DESCRIPTION 
This script converts a BTO Acoustic Pipeline results file (.csv) to a file that can be opened and analysed in Kaleidoscope.

## TO RUN
Place your BTO Pipeline results file (.csv), this script and the sound files that were analysed by BTO Pipeline in the same folder. Run this script from that location. A file with your converted results will be created in the working directory, called Converted_BTO_results.csv. Open this file in Kaleidoscope as you would a normal results file (meta.csv): File > Open Results. 
 
## COLUMN MAPPING
Kaleidoscope uses fixed column header-names that cannot be changed in the free version. Therefore this script re-uses those pre-existing column names and maps them to BTO's column names as follows: 

'IN FILE*' = 'ORIGINAL.FILE.NAME'

'DATE' = 'ACTUAL.DATE'

'AUTO ID' = 'SPECIES'

'FIRMWARE' = 'SPECIES.GROUP' 

'PREFIX' = 'CALL.TYPE'

'MATCH RATIO' = 'PROBABILITY'

'NOTES' = 'BATCH.NAME'

Certain columns share the same names, like 'TIME', 'LATITUDE', 'LONGITDUDE', etc. Note that many of the columns from BTO Pipeline's results have been removed. 

## COLUMNS IN CONVERTED FILE

INDIR

IN FILE*

DATE

TIME

LATITUDE

LONGITUDE

FIRMWARE

PREFIX

NOTES

AUTO ID

MATCH RATIO

MANUAL ID

REVIEW USERID

INPATHMD5

## NOTE
If you can't see these columns in Kaleidoscope, choose to show them in File > Edit columns. 

## AUTHOR
Lark Davis
lark.isadora.davis@gmail.com
