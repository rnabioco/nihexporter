#! /usr/bin/env bash

## download raw data from NIH EXPORTER database
##
## takes ~20 minutes on a high-speed connection.

urlbase="https://exporter.nih.gov/CSVs/final/"

## common functions ----------------------------

download_files () {

    dir=$1
    urlbase=$2
    zipfile=$3

    if [ ! -d $dir ]; then
        mkdir $dir
    fi

    url="$urlbase/$zipfile"

    echo -n ">> downloading $zipfile ... "
    
    if [[ -f "$dir/$zipfile" ]]; then

        # check file size
        targetsize=$(wget --spider -S $url 2>&1 \
            | grep '^Length' | cut -f2 -d' ')

        filesize=$(wc -c "$dir/$zipfile" | cut -f1 -d' ')

        if [ $targetsize -eq $filesize ]; then
            echo "file exists, skipping."
            return 0
        fi
    fi

    wget -q --tries 5 -O $dir/$zipfile $url
    echo "done."
}

unzip_files () {

    dir=$1

    if [[ ! -d $dir ]]; then
        echo "unzip error: directory $dir does not exist"
        exit 1
    fi

    for zipfile in $dir/*.zip; do
        unzip -of -d $dir $zipfile
    done
}

## PROJECTS ------------------------------------
years=$(seq 1985 2016)
dir='PROJECTS'

for year in ${years[@]}; do
    zipfile="RePORTER_PRJ_C_FY$year.zip"
    download_files $dir $urlbase $zipfile
done

unzip_files $dir

## PATENTS -------------------------------------
dir='PATENTS'

zipfile="RePORTER_PATENTS_C_ALL.zip"
download_files $dir $urlbase $zipfile

unzip_files $dir

## PUBLICATIONS --------------------------------
years=$(seq 1980 2016)
dir='PUBLICATIONS'

for year in ${years[@]}; do
    zipfile="RePORTER_PUB_C_$year.zip"
    download_files $dir $urlbase $zipfile
done

unzip_files $dir

## PUBLINKS ------------------------------------
years=$(seq 1985 2016)
dir='PUBLINKS'

for year in ${years[@]}; do
    zipfile="RePORTER_PUBLNK_C_$year.zip"
    download_files $dir $urlbase $zipfile
done

unzip_files $dir

## CLINICAL_STUDIES ----------------------------
dir='CLINICAL_STUDIES'

zipfile="RePORTER_CLINICAL_STUDIES_C_ALL.zip"
download_files $dir $urlbase $zipfile

unzip_files $dir

## DUNS_FIXES ----------------------------------
years=$(seq 2000 2008)
dir='DUNS_FIX'

for year in ${years[@]}; do
    zipfile="RePORTER_DUNS_C_FY$year.zip"
    download_files $dir $urlbase $zipfile
done

unzip_files $dir

## FY FUNDING FOR 1985-1999 --------------------
years=$(seq 1985 1999)
dir="FY1985-FY1999-FUNDING"

for year in ${years[@]}; do
    zipfile="RePORTER_PRJFUNDING_C_FY$year.zip"
    download_files $dir $urlbase $zipfile
done

unzip_files $dir 
