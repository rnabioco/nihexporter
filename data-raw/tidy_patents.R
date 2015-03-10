library(dplyr)
library(stringr)
library(tidyr)
library(lubridate)
library(data.table)

# PUBLINKS tables
path = 'data-raw//PATENTS'
csvfiles <- dir(path, pattern = '\\.csv', full.names = TRUE)
tables <- lapply(csvfiles, read.csv, header = TRUE)

patents <- rbindlist(tables)
patents.tbl <- tbl_df(patents)

names(patents.tbl) <- names(patents.tbl) %>%
  str_to_lower() %>%
  str_replace_all('_','.')

patents <- patents.tbl %>%
  select(patent.id, project.id) %>%
  rename(project.num = project.id) %>%
  arrange(project.num)

save(patents, file = 'data/patents.rdata', compress = 'xz')