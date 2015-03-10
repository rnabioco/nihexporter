
library(dplyr)
library(stringr)
library(tidyr)
library(lubridate)
library(data.table)

# PUBLINKS tables
path = 'data-raw//PUBLINKS'
csvfiles <- dir(path, pattern = '\\.csv', full.names = TRUE)
tables <- lapply(csvfiles, read.csv, header = TRUE)

publinks <- rbindlist(tables)
publinks.tbl <- tbl_df(publinks)

names(publinks.tbl) <- names(publinks.tbl) %>%
  str_to_lower() %>%
  str_replace_all('_','.')

publinks <- publinks.tbl %>%
  mutate(pmid = as.character(pmid)) %>%
  rename(project.num = project.number) %>%
  arrange(project.num)

save(publinks, file = 'data/publinks.rdata', compress = 'xz')
