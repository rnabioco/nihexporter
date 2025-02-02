
# nihexporter

<!-- badges: start -->

[![R-CMD-check](https://github.com/rnabioco/nihexporter/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rnabioco/nihexporter/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The `nihexporter` R package provides a minimal set of data from the [NIH
EXPORTER](https://reporter.nih.gov/exporter) database, which contains
information on NIH biomedical research funding from 1985-2024.

To keep the package lightweight, many details are omitted but can be
easily retrieved from [NIH RePORTER](https://reporter.nih.gov/).

## Installation

Install the package from github with:

``` r
# install.packages('pak')
pak::pak("rnabioco/nihexporter")
```

⚠️**Note:** this is a large data package (\>50 Mb) and will take some
time to download and install. ⚠️

## Tables

- `projects`: provides data on funded projects by NIH.

- `project_pis`: links project numbers (`project.num`) to principal
  investigator IDs (`pi.id`).

- `publinks`: links Pubmed IDs (`pmid`) to project numbers
  (`project.num`).

- `publications`: provides information for individual publications,
  including their [Relative Citation Ratio](https://icite.od.nih.gov)
  values (`rcr`).

- `patents`: links project IDs (`project.num`) to `patent.id`.

- `clinical_studies`: links project IDs to associated [clinical
  trials](https://clinicaltrials.gov/).

- `project_io`: pre-computed `n.pubs`, `n.patents` and `project.cost`
  for each `project.num`.

- `abstract_words`: tokenized words from [grant
  abstracts](https://reporter.nih.gov/exporter/abstracts).

## Functions

- `rcr()` retrieves [Relative Citation
  Ratios](https://icite.od.nih.gov/) and associated information for
  PubMed IDs.

- `nihexporter_sqlite()` can be used to cache data in a local SQLite
  database.

## Variables

- `nih.institutes`: 27 NIH institutes in two-letter format

## Resources

- [`nihexporter` pre-print on
  bioRxiv](https://biorxiv.org/content/early/2015/12/02/033456)

- [RePORTER / EXPORTER mailing list
  archives](https://list.nih.gov/cgi-bin/wa.exe?A0=NIH-REPORT-PUBLIC-L)

- [Relative Citation Ratio manuscript at
  PLoS](https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1002541)
