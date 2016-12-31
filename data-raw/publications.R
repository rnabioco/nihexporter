#' create `publications` table

library(nihexporter)
library(dplyr)
library(stringr)
library(tidyr)
library(lubridate)
library(purrr)
library(readr)

path <- 'data-raw//PUBLICATIONS'
csvfiles <- dir(path, pattern = '\\.csv', full.names = TRUE)

col_types = '_c____c___ii__i'
tables <- lapply(csvfiles, function(x) read_csv(x, col_types = col_types))

publications <- bind_rows(tables)
publications.tbl <- tbl_df(publications)

## coerce colnames
names(publications.tbl) <- names(publications.tbl) %>%
  str_to_lower() %>%
  str_replace_all('_','.')

## make publications table
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

rcrs <- purrr::map(chunks, rcr) %>%
  data_frame() %>% unnest()

publications <- publications %>% left_join(rcrs, by = 'pmid') %>%
  select(pmid, pmc.id, pub.year, relative_citation_ratio) %>%
  rename(rcr = relative_citation_ratio)

save(publications, file = 'data/publications.rdata', compress = 'xz')
