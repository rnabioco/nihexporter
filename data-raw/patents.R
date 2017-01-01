library(dplyr)
library(stringr)
library(tidyr)
library(readr)

# PUBLINKS tables
path = 'data-raw//PATENTS'
csvfiles <- dir(path, pattern = '\\.csv', full.names = TRUE)
tables <- lapply(csvfiles, read_csv)

patents <- bind_rows(tables)
patents.tbl <- tbl_df(patents)

names(patents.tbl) <- names(patents.tbl) %>%
  str_to_lower() %>%
  str_replace_all('_','.')

patents <- patents.tbl %>%
  select(patent.id, project.id) %>%
  rename(project.num = project.id) %>%
  filter(!grepl('-', project.num)) %>%
  arrange(project.num)

save(patents, file = 'data/patents.rdata', compress = 'xz')
