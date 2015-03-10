#! /usr/bin/env bash

#BSUB -J dload.patents
#BSUB -o dload.patents.%J.out
#BSUB -e dload.patents.%J.err

url="http://exporter.nih.gov/CSVs/final/RePORTER_PATENTS_C_ALL.zip"

wget $url

for zipfile in *.zip; do
    unzip $zipfile
done
