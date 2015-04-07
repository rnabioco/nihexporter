### `publications` and `authors` table - currently not implemented

library(dplyr)
library(stringr)
library(tidyr)
library(lubridate)
library(readr)

path = 'data//PUBLICATIONS'
csvfiles <- dir(path, pattern = '\\.csv', full.names = TRUE)[1]
tables <- lapply(csvfiles, read_csv, header = TRUE)

publications <- rbind_all(tables)
publications.tbl <- tbl_df(publications)
#
## make authors table
## coerce colnames
names(publications.tbl) <- names(publications.tbl) %>%
  str_to_lower() %>%
  str_replace_all('_','.')

authors <- publications.tbl %>%
  select(author.list, pmid) %>%
  separate(author.list, into = c(1:20), sep = ';', extra = 'drop') %>%
  gather(pmid) %>%
  setNames(c('pmid', 'author.num', 'name')) %>%
  filter(!is.na(author.num)) %>%
  select(pmid, name) %>%
  mutate(pmid = as.factor(pmid))

save(authors, file = 'data/authors.rdata', compress = 'xz')
#
## make publications table
publications <- publications.tbl %>%
  filter(author.list != '') %>%
  select(country, lang, pmid, pub.date, pub.year) %>%
  mutate(pub.date = as.factor(ymd(pub.date)), 
         pmid = as.factor(pmid),
         pub.year = as.factor(pub.year),
         lang = str_to_lower(lang))

save(publications, file = 'data/publications.rdata', compress = 'xz')

