### `publications` and `authors` table

library(dplyr)
library(stringr)
library(tidyr)
library(lubridate)
library(readr)

path = 'data-raw//PUBLICATIONS'
csvfiles <- dir(path, pattern = '\\.csv', full.names = TRUE)

col_types = '_c____c___ii__i'
tables <- lapply(csvfiles, function(x) read_csv(x, col_types = col_types))

publications <- rbind_all(tables)
publications.tbl <- tbl_df(publications)
#
## make authors table
## coerce colnames
names(publications.tbl) <- names(publications.tbl) %>%
  str_to_lower() %>%
  str_replace_all('_','.')

# authors <- publications.tbl %>%
#   select(author.list, pmid) %>%
#   separate(author.list, into = c(1:20), sep = ';', extra = 'drop') %>%
#   gather(pmid) %>%
#   setNames(c('pmid', 'author.num', 'name')) %>%
#   filter(!is.na(author.num)) %>%
#   select(pmid, name) %>%
#   mutate(pmid = as.factor(pmid))
# 
# save(authors, file = 'data/authors.rdata', compress = 'xz')

## make publications table
publications <- publications.tbl %>%
  select(pmid, pmc.id, pub.year, journal.title.abbr) %>%
  mutate(pub.year = as.factor(pub.year),
         journal.title.abbr = as.factor(journal.title.abbr))

save(publications, file = 'data/publications.rdata', compress = 'xz')
