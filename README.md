# nih-exporter

This package providesa minimal set of data from NIH EXPORTER
<http://exporter.nih.gov/default.aspx>, which contains data on NIH
biomedical research funding from 1985-2014 (and continues).

The package contains the following tables:

* `projects`: provides data on funded projects by NIH. The following
  columns are available: 

    - 
    -
    -

* `org`: information by funded organizations.

* `pi.names`: links PI names (`pi.name`) to project numbers
  (`project.num`)

* `publinks`: links Pubmed IDs (`pmid`) to project numbers (`project.num`)

Install it from github with:
  
```
devtools::install_github("jayhesselberth/nih-exporter")
```
