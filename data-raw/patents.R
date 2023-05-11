#' load and parse patent CSV files

source('data-raw/common.R')

path <- here('data-raw/downloads/Patents.csv')
patents_tbl <- read_csv(path) |>
  janitor::clean_names()

patents <- patents_tbl |>
  select(patent_id, project_id) %>%
  rename(project_num = project_id) %>%
  filter(!grepl('-', project_num)) %>%
  arrange(project_num)

use_data(patents, compress = 'xz', overwrite = TRUE)
