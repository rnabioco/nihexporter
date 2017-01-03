#' create `publications` table

source('data-raw/common.R')

## provides `rcr()`
source('R/rcr.R')

path <- 'data-raw//PUBLICATIONS'
col_types = '_c____c___ii__i'
publications.tbl <- load_tbl(path, col_types)

publications <- publications.tbl %>%
  select(pmid, pmc.id, pub.year)

## chunk pmids and fetch rcr values

## iCite only has data from 1995 to 2016
pubs <- publications %>%
  filter(pub.year >= 1995) %>%
  select(pmid)
pmids <- pubs$pmid

## chunk size
n <- 500
chunks <- split(pmids, ceiling(seq_along(pmids) / n))

## this takes ~60 minutes
rcrs <- purrr::map(chunks, rcr) %>%
  data_frame() %>% unnest()

publications <- publications %>%
  left_join(rcrs, by = 'pmid') %>%
  select(pmid, pmc.id, pub.year, relative_citation_ratio) %>%
  rename(rcr = relative_citation_ratio) %>%
  unique()

use_data(publications, compress = 'xz')
