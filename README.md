# nihexporter

This package provides a minimal set of data from NIH EXPORTER
<http://exporter.nih.gov/default.aspx>, which contains information on NIH
biomedical research funding from 1985-2014 (and continues).

The package contains the following tables:

* `projects`: provides data on funded projects by NIH. The following
  columns are available: 

    - `application.id`
    - `institute`
    - `activity` (i.e., grant type)
    - `project.num` (i.e., ref to `publinks`)
    - `fiscal.year`
    - `project.start`
    - `project.end`
    - `study.section`
    - `total.cost`

* `publinks`: links Pubmed IDs (`pmid`) to project numbers (`project.num`)

Install it from github with:
  
```
devtools::install_github("jayhesselberth/nihexporter")
```
