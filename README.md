
nihexporter
===========

[![Travis-CI Build Status](https://travis-ci.org/jayhesselberth/nihexporter.png?branch=master)](https://travis-ci.org/jayhesselberth/nihexporter) [![CRAN status](https://www.r-pkg.org/badges/version/nihexporter)](https://www.r-pkg.org/badges/version/nihexporter)

The `nihexporter` R package provides a minimal set of data from the [NIH EXPORTER](http://exporter.nih.gov/default.aspx) database, which contains information on NIH biomedical research funding from 1985-2016.

To keep the package lightweight, many details are omitted but can be easily retrieved from [NIH RePORTER](https://projectreporter.nih.gov/).

Installation
------------

Install the package from github with:

``` r
# install.packages('devtools')
devtools::install_github("jayhesselberth/nihexporter")
```

**Note**: this is a large data package (&gt;40 Mb), so [it will likely never be available on CRAN](http://thecoatlessprofessor.com/programming/size-and-limitations-of-packages-on-cran/).

### Tables

-   `projects`: provides data on funded projects by NIH.

-   `project_pis`: links project numbers (`project.num`) to principal investigator IDs (`pi.id`).

-   `project_orgs`: links DUNS numbers (`org.duns`) from `projects` table to information on specific organizations .

-   `publinks`: links Pubmed IDs (`pmid`) to project numbers (`project.num`).

-   `publications`: provides information for specific publications, including (**coming soon**) their [Relative Citation Ratio](https://icite.od.nih.gov) values (`rcr`).

-   `patents`: links project IDs (`project.num`) to `patent.id`.

-   `clinical_studies`: links project IDs to associated [clinical trials](https://clinicaltrials.gov/).

-   `project_io`: pre-computed `n.pubs`, `n.patents` and `project.cost` for each `project.num`.

### Functions

-   `rcr()` retrieves [Relative Citation Ratios](https://icite.od.nih.gov/) and associated information for PubMed IDs.

### Variables

-   `nih.institutes`: 27 NIH institutes in two-letter format

Examples
--------

### Fiscal summaries

We can use the `nihexporter` package to find the top-ten all-time most expensive grants.

``` r
library(nihexporter)
library(dplyr)

expensive_projects <- project_io %>%
  arrange(desc(total.cost)) %>%
  head(10) %>%
  left_join(projects, by = 'project.num') %>%
  select(project.num, institute, total.cost) %>% 
  unique() %>%
  mutate(cost.billions = total.cost / 1e9)

expensive_projects
#> # A tibble: 10 × 4
#>    project.num institute total.cost cost.billions
#>          <chr>    <fctr>      <dbl>         <dbl>
#> 1  ZIHLM200888        LM 1544981304     1.5449813
#> 2  ZIFBC000001        CA  652060692     0.6520607
#> 3  U54HG003067        HG  527942706     0.5279427
#> 4  U54HG003079        HG  414975466     0.4149755
#> 5  ZIFAI000001        AI  389496063     0.3894961
#> 6  U10CA098543        CA  335523333     0.3355233
#> 7  U54HG003273        HG  305945737     0.3059457
#> 8  U19AI067854        AI  290473421     0.2904734
#> 9  U54HG002045        HG  242268294     0.2422683
#> 10  N01CO12400        CA  225180953     0.2251810
```

The most expensive project (`ZIHLM200888`) funds the National Library of Medicine's intramural program, including [PubMed](pubmed.com) and the [NCBI](https://www.ncbi.nlm.nih.gov/), which provides BLAST, GenBank, RefSeq and dbGAP.

Resources
---------

-   [`nihexporter` pre-print on bioRxiv](http://biorxiv.org/content/early/2015/12/02/033456)

-   [RePORTER / EXPORTER mailing list archives](https://list.nih.gov/cgi-bin/wa.exe?A0=NIH-REPORT-PUBLIC-L)
