#! /usr/bin/env bash

#BSUB -J dload.publinks
#BSUB -o dload.publinks.%J.out
#BSUB -e dload.publinks.%J.err

years=$(seq 1985 2015)
urlbase="http://exporter.nih.gov/CSVs/final/RePORTER_PUBLNK_C_" # YEAR.zip

for year in ${years[@]}; do
    wget "$urlbase""$year.zip"
done

for zipfile in *.zip; do
    unzip $zipfile
done
