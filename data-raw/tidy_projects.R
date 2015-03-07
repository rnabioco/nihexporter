library(dplyr)
library(stringr)
library(tidyr)
library(lubridate)
library(data.table)

## PROJECTS tables

# load projects data
path = 'data-raw//PROJECTS'
csvfiles <- dir(path, pattern = '\\.csv', full.names = TRUE)
# csvfiles <- tail(dir(path, pattern = '\\.csv', full.names = TRUE), 1)

tables <- lapply(csvfiles, read.csv, header = TRUE)

projects.tbl <- rbindlist(tables)
projects.tbl <- tbl_df(projects.tbl)

# coerce colnames
names(projects.tbl) <- names(projects.tbl) %>%
  str_to_lower() %>%
  str_replace_all('_','.')

# org table
project.orgs <- projects.tbl %>%
  select(org.city:org.state) %>%
  select(-(org.dept:org.fips)) %>%
  distinct()
save(project.orgs, file = 'data/project.orgs.rdata')

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

# projects table
projects <- projects.tbl %>%
  select(application.id, activity, core.project.num, full.project.num,
         fy, org.name, project.start, project.end,
         study.section, support.year, total.cost, total.cost.sub.project) %>%
  rename(project.num = core.project.num) %>%  
  mutate(project.end = mdy(project.end),
         project.start = mdy(project.start),
         support.year = factor(support.year))
save(project, file = 'data/projects.rdata')         
