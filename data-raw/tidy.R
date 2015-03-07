library(dplyr)
library(stringr)
library(tidyr)
library(lubridate)
library(data.table)

## PROJECTS tables

# load projects data
path = 'data-raw//PROJECTS'
csvfiles <- dir(path, pattern = '\\.csv', full.names = TRUE)[1]
tables <- lapply(csvfiles, read.csv, header = TRUE)

projects.tbl <- rbindlist(tables)
projects.tbl <- tbl_df(projects.tbl)

# coerce colnames
names(projects.tbl) <- names(projects.tbl) %>%
  str_to_lower() %>%
  str_replace_all('_','.')

# org table
project.orgs <- projects.tbl %>%
  select(org.city:org.zipcode) %>%
  distinct()
save(project.orgs, 'data/project.orgs.rdata')

# project.pis table
project.pis <- projects.tbl %>%
  select(application.id, pi.names) %>%
  separate(pi.names, into = c(1:20), sep = ';', extra = 'drop') %>%
  gather(application.id) %>%
  setNames(c('application.id', 'pi.num', 'pi.name')) %>%
  filter(!is.na(pi.name)) %>%
  select(application.id, pi.name) %>%
  mutate(application.id = as.factor(application.id))
save(project.pis, file = 'data/project.pis.rdata')

# projects table TODO
projects <- projects.tbl %>%
  select(application.id, actvitiy, XXX

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
  mutate(pmid = as.factor(pmid))

save(publinks, file = 'data/publinks.rdata')

### PUBLICATIONS tables - UNUSED
#Read in Publication CSV files, save the following columns:
#
#- `author.list` -> `author`
#- `country`
#- `lang` 
#- `pmid`
#- `pub.date`
#- `pub.year`
#
#split these into two tables:
#
#- authors: with `name` and `pmid`
#- publications: with everything else, linked by `pmid`
#
#### Loading
#
#path = 'data//PUBLICATIONS'
#csvfiles <- dir(path, pattern = '\\.csv', full.names = TRUE)[1]
#tables <- lapply(csvfiles, read.csv, header = TRUE)
#
#publications <- rbindlist(tables)
#publications.tbl <- tbl_df(publications)
#
## make authors table
## coerce colnames
#names(publications.tbl) <- names(publications.tbl) %>%
#  str_to_lower() %>%
#  str_replace_all('_','.')
#
#authors <- publications.tbl %>%
#  select(author.list, pmid) %>%
#  separate(author.list, into = c(1:20), sep = ';', extra = 'drop') %>%
#  gather(pmid) %>%
#  setNames(c('pmid', 'author.num', 'name')) %>%
#  filter(!is.na(author.num)) %>%
#  select(pmid, name) %>%
#  mutate(pmid = as.factor(pmid))
#
## saveRDS(authors, file = 'authors.Rds')
#
## make publications table
#publications <- publications.tbl %>%
#  filter(author.list != '') %>%
#  select(country, lang, pmid, pub.date, pub.year) %>%
#  mutate(pub.date = as.factor(ymd(pub.date)), 
#         pmid = as.factor(pmid),
#         pub.year = as.factor(pub.year),
#         lang = str_to_lower(lang))
#
## saveRDS(publications, file = 'publications.Rds')
#
#
