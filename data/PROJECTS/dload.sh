#! /usr/bin/env bash

years=$(seq 1985 2014)
urlbase="http://exporter.nih.gov/CSVs/final/RePORTER_PRJ_C_FY" # YEAR.zip

for year in ${years[@]}; do
    wget "$urlbase""$year.zip"
done

