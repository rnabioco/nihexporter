#! /usr/bin/env bash

#BSUB -J dload.projects
#BSUB -o dload.projects.%J.out
#BSUB -e dload.projects.%J.err

years=$(seq 2000 2014)
urlbase="http://exporter.nih.gov/CSVs/final/RePORTER_PRJ_C_FY" # YEAR.zip

for year in ${years[@]}; do
    wget "$urlbase""$year.zip"
done

for zipfile in *.zip; do
    unzip $zipfile
done
