# tidy_projects
# 
# loads CSV files from NIH EXPORTER into tbl_df format
#
library(dplyr)
library(stringr)
library(tidyr)
library(lubridate)
library(data.table)
library(pbapply)

## PROJECTS tables

# load projects data
path = 'data-raw//PROJECTS'
csvfiles <- dir(path, pattern = '\\.csv', full.names = TRUE)
# csvfiles <- tail(dir(path, pattern = '\\.csv', full.names = TRUE), 1)

tables <- pblapply(csvfiles, read.csv, header = TRUE)

projects.tbl <- rbindlist(tables, fill = TRUE)
projects.tbl <- tbl_df(projects.tbl)

# coerce colnames
names(projects.tbl) <- names(projects.tbl) %>%
  str_to_lower() %>%
  str_replace_all('_','.')

# org table - link on org.duns
project.orgs <- projects.tbl %>%
  select(org.city, org.state, org.duns, org.name) %>%
  filter(org.duns != '') %>%
  distinct() %>%
  arrange(org.duns)
save(project.orgs, file = 'data/project.orgs.rdata', compress = 'xz')

# project.pis table
project.pis <- projects.tbl %>%
  select(core.project.num, pi.ids) %>%
  rename(project.num = core.project.num) %>%
  separate(pi.ids, into = c(1:20), sep = ';', extra = 'drop') %>%
  gather(project.num) %>%
  setNames(c('project.num', 'pi.num', 'pi.id')) %>%
  filter(pi.id != '') %>%
  select(project.num, pi.id) %>%
  arrange(project.num)
save(project.pis, file = 'data/project.pis.rdata', compress = 'xz')

# projects table - only provide data after fy 2000 as costs are only available 2000 and onward.
projects <- projects.tbl %>%
  select(administering.ic, activity,
         core.project.num, fy, org.duns,
         project.start, project.end,
         study.section, suffix, total.cost) %>%
  rename(project.num = core.project.num,
         fiscal.year = fy,
         institute = administering.ic) %>%  
  mutate(project.end = mdy(project.end),
         project.start = mdy(project.start))
save(projects, file = 'data/projects.rdata', compress = 'xz')         
