library(dplyr)
library(stringr)
library(tidyr)
library(readr)

# PUBLINKS tables
path = 'data-raw//PATENTS'
csvfiles <- dir(path, pattern = '\\.csv', full.names = TRUE)
tables <- lapply(csvfiles, read_csv)

patents <- rbind_all(tables)
patents.tbl <- tbl_df(patents)

names(patents.tbl) <- names(patents.tbl) %>%
  str_to_lower() %>%
  str_replace_all('_','.')

patents <- patents.tbl %>%
  select(patent.id, project.id) %>%
  rename(project.num = project.id) %>%
  arrange(project.num)

save(patents, file = 'data/patents.rdata', compress = 'xz')
