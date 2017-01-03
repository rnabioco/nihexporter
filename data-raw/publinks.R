#' parse  PUBLINKS tables

source('data-raw/common.R')

path = 'data-raw//PUBLINKS'
publinks.tbl <- load_tbl(path)

publinks <- publinks.tbl %>%
  mutate(pmid = as.integer(pmid)) %>%
  rename(project.num = project.number) %>%
  filter(!grepl('-', project.num)) %>%
  arrange(project.num) %>%
  unique()

use_data(publinks, compress = 'xz')
