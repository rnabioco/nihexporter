#' create `publications` table

source('data-raw/common.R')

## provides `rcr()`
source('R/rcr.R')
path <- 'data-raw/downloads/pubs'

col_types <- cols_only(
  PMID = col_double(),
  PMC_ID = col_double(),
  PUB_YEAR = col_character()
)

publications_tbl <- load_tbl(path, col_types)

publications <- publications_tbl %>%
  select(pmid, pmc_id, pub_year)

## chunk pmids and fetch rcr values

## iCite only has data from 1995 to 2016
pubs <- publications %>%
  filter(pub_year >= 1995) %>%
  select(pmid)
pmids <- pubs$pmid

## chunk size
n <- 1000
chunks <- split(pmids, ceiling(seq_along(pmids) / n))

## this takes ~10 minutes
library(furrr)
plan(multisession, workers = 6)
rcrs <- furrr::future_map(chunks, rcr) |>
  tibble() |>
  unnest()

publications <- publications |>
  left_join(rcrs, by = 'pmid', relationship = "many-to-many") |>
  select(pmid, pmc_id, pub_year, relative_citation_ratio) |>
  rename(rcr = relative_citation_ratio) |>
  unique()

use_data(publications, compress = 'xz', overwrite = TRUE)
