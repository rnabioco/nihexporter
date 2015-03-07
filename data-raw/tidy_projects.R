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

projects.tbl <- rbindlist(tables, fill = TRUE)
projects.tbl <- tbl_df(projects.tbl)

# coerce colnames
names(projects.tbl) <- names(projects.tbl) %>%
  str_to_lower() %>%
  str_replace_all('_','.')

# org table
#project.orgs <- projects.tbl %>%
#  select(org.city:org.state) %>%
#  select(-(org.dept:org.fips)) %>%
#  distinct() %>%
#  mutate(org.id = seq_along(org.name))
#save(project.orgs, file = 'data/project.orgs.rdata')

# project.pis table - select the last PI from the list
#project.pis <- projects.tbl %>%
#  select(application.id, pi.names) %>%
#  separate(pi.names, into = c(1:20), sep = ';', extra = 'drop') %>%
#  gather(application.id) %>%
#  setNames(c('application.id', 'pi.num', 'pi.name')) %>%
#  filter(!is.na(pi.name)) %>%
#  group_by(application.id) %>%
#  arrange(desc(pi.num)) %>%
#  slice(1:1) %>%
#  select(application.id, pi.name) %>%
#  mutate(application.id = as.factor(application.id))
#save(project.pis, file = 'data/project.pis.rdata')

# projects table
projects <- projects.tbl %>%
  select(application.id, administering.ic, activity,
         core.project.num, fy,
         project.start, project.end,
         study.section, total.cost) %>%
  rename(project.num = core.project.num,
         fiscal.year = fy,
         institute = administering.ic) %>%  
  mutate(project.end = mdy(project.end),
         project.start = mdy(project.start))
save(projects, file = 'data/projects.rdata')         
