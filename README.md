
`nihexporter`
=============

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

**Note**: this is a large data package (&gt;40 Mb), so [it will not be submitted to CRAN](http://thecoatlessprofessor.com/programming/size-and-limitations-of-packages-on-cran/).

### Tables

-   `projects`: provides data on funded projects by NIH.

-   `project_pis`: links project numbers (`project.num`) to principal investigator IDs (`pi.id`).

-   `project_orgs`: links DUNS numbers (`org.duns`) from `projects` table to information on specific organizations .

-   `publinks`: links Pubmed IDs (`pmid`) to project numbers (`project.num`).

-   `publications`: provides information for individual publications, including their [Relative Citation Ratio](https://icite.od.nih.gov) values (`rcr`).

-   `patents`: links project IDs (`project.num`) to `patent.id`.

-   `clinical_studies`: links project IDs to associated [clinical trials](https://clinicaltrials.gov/).

-   `project_io`: pre-computed `n.pubs`, `n.patents` and `project.cost` for each `project.num`.

**Note:** [Abstracts](https://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=0&index=1) from NIH EXPORTER are not provided because they significantly increase the size of the package.

### Functions

-   `rcr()` retrieves [Relative Citation Ratios](https://icite.od.nih.gov/) and associated information for PubMed IDs.

-   `nihexporter_sqlite()` can be used to cache data in a local SQLite database.

### Variables

-   `nih.institutes`: 27 NIH institutes in two-letter format

Examples
--------

### Activity spending and numbers

The animated plot below shows the trajactory of activity spending and number over time for select activities (e.g., R01 and P01) for some institutes. It indicates that U01 and R21 activities have had significant recent investment from certain institutes, whereas R01 and P01 activities have remained relatively constant in number and spending.

``` r
library(nihexporter)
library(tidyverse)
library(gganimate)

insts <- c('GM', 'AI', 'CA', 'HL', 'DK', 'NS')
activities <- c('R01', 'R21', 'P01', 'U01')

costs <- projects %>%
  filter(institute %in% insts & activity %in% activities) %>%
  group_by(fiscal.year, institute, activity) %>%
  summarize(n.projects = n(),
            project.costs = sum(fy.cost, na.rm = TRUE) / 1e6)

gp <- ggplot(costs, aes(x = n.projects,
                        y = project.costs,
                        color = institute,
                        frame = fiscal.year)) +
  scale_x_log10() + scale_y_log10() +
  facet_wrap(~ activity) +
  scale_color_brewer(palette = 'Dark2') +
  labs(x = 'Number of projects',
       y = 'Total spending on activity (millions)',
       title = 'Values for FY')

p <- gp + geom_path(aes(cumulative = TRUE,
                        group = institute),
                    arrow = arrow(length = unit(0.1, "npc")))

gganimate(p)
```

![''](img/README-cost-.gif)

### Fiscal summaries

One can also use the `nihexporter` package to examine spending among the institutes. For example, here we identify the top-ten all-time most expensive projects.

The most expensive project below (`ZIHLM200888`) funds the National Library of Medicine's intramural program, including [PubMed](http://pubmed.com) and the [NCBI](https://www.ncbi.nlm.nih.gov/), which provides BLAST, GenBank, RefSeq and dbGAP.

``` r
library(nihexporter)
library(dplyr)
library(scales)

expensive_projects <- project_io %>%
  arrange(desc(total.cost)) %>%
  head(10) %>% 
  left_join(projects, by = 'project.num') %>%
  select(project.num, institute, total.cost) %>% 
  unique() %>%
  mutate(total.cost = comma(total.cost)) %>%
  setNames(c('Project', 'Institute', 'Total cost (USD)'))

expensive_projects
#> # A tibble: 10 x 3
#>        Project Institute `Total cost (USD)`
#>          <chr>    <fctr>              <chr>
#>  1 ZIHLM200888        LM      1,544,981,304
#>  2 ZIFBC000001        CA        652,060,692
#>  3 U54HG003067        HG        527,942,706
#>  4 U54HG003079        HG        414,975,466
#>  5 ZIFAI000001        AI        389,496,063
#>  6 U10CA098543        CA        335,523,333
#>  7 U54HG003273        HG        305,945,737
#>  8 U19AI067854        AI        290,473,421
#>  9 U54HG002045        HG        242,268,294
#> 10  N01CO12400        CA        225,180,953
```

Resources
---------

-   [`nihexporter` pre-print on bioRxiv](http://biorxiv.org/content/early/2015/12/02/033456)

-   [RePORTER / EXPORTER mailing list archives](https://list.nih.gov/cgi-bin/wa.exe?A0=NIH-REPORT-PUBLIC-L)

-   [Relative Citation Ratio manuscript at PLoS](http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1002541)
