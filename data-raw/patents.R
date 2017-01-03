#' load and parse patent CSV files

source('data-raw/common.R')

path = 'data-raw//PATENTS'
patents.tbl <- load_tbl(path)

patents <- patents.tbl %>%
  select(patent.id, project.id) %>%
  rename(project.num = project.id) %>%
  filter(!grepl('-', project.num)) %>%
  arrange(project.num)

use_data(patents, compress = 'xz')
