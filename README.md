# nihexporter

This package provides a minimal set of data from NIH EXPORTER
<http://exporter.nih.gov/default.aspx>, which contains information on NIH
biomedical research funding from 1985-2014 (and continues monthly in a given fiscal year).

The package contains the following tables:

* `projects`: provides data on funded projects by NIH. The following
  columns are available: 

    - `institute`: two letter format
    - `activity` (i.e., grant type)
    - `project.num` (i.e., ref to `publinks`)
    - `fiscal.year`
    - `project.start`: `mdy` format from `lubridate`
    - `project.end`: `mdy` format
    - `study.section`: `MGB` etc.
    - `total.cost`: direct + indirect

* `publinks`: links Pubmed IDs (`pmid`) to project numbers (`project.num`)

# Importing the data

There is a lot of data in NIH EXPORTER, so this package aims to provide a minimal set of data without being too unwieldy. There are download and import (`tidy_projects.R`) scripts in the `data-raw/` directory in the package.

In the future, we might offer `project.pis` and `project.org` tables, to see the who and where of NIH investment. See #1.

Install it from github with:
  
```
devtools::install_github("jayhesselberth/nihexporter")
```
