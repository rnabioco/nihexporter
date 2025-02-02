#' parse  PUBLINKS tables

source("data-raw/common.R")

path <- here("data-raw/downloads/publinks")
publinks_tbl <- load_tbl(path)

publinks <- publinks_tbl %>%
  mutate(pmid = as.integer(pmid)) %>%
  rename(project_num = project_number) %>%
  filter(!grepl("-", project_num)) %>%
  arrange(project_num) %>%
  unique()

use_data(publinks, compress = "xz", overwrite = TRUE)
