#' load project_orgs and org_info

source('data-raw/common.R')

## org table
##
## - linked to projects by the DUNS number
##   https://en.wikipedia.org/wiki/Data_Universal_Numbering_System
##
## - DUNS are 9 digit numbers. Because they can start with a zero,
##   we need to keep them as characters.
##
## - the CSV contains some entries with multiple DUNS that need to be
##   separated (e.g., 001810881; 008905093)
##
## - in the raw CSVs, there are several incorrectly formatted DUNS columns:
##
##   * DUNS with less than 9 digits (2,997)
##   * multiple DUNS delimited by semicolons (39)
##   * "DUNS" with hyphens (4): not clear if these are actually DUNS (example: 10-932-78)
##
##
org_info <- projects.tbl %>%
  # remove incorrect DUNS in 2008 and prior
  filter(fy >= 2009) %>%
  select(org.city, org.state, org.duns, org.name) %>%
  separate(org.duns, into = as.character(c(1:20)), sep = ';', extra = 'drop') %>%
  filter(!is.na(org.duns)) %>%
  mutate(org.duns = str_trim(org.duns),
         org.state = as.factor(org.state),
         org.city = as.factor(org.city)) %>%
  distinct() %>%
  arrange(org.duns)

#' load fixes for DUNS numbers and parse here
duns_path <- 'data-raw//DUNS_FIX'
duns_col_types <- cols(
  APPLICATION_ID = col_integer(),
  ORG_DUNS = col_character()
)

duns.tbl <- load_tbl(duns_path, duns_col_types)

# now join the DUNS numbers. we want DUNS from the new tables from 2000-2008 (those are WRONG in the project.tbl),
# and the DUNS from 2009 onward are correct in the projects.tbl
old_duns <- duns.tbl %>%
  left_join(projects, by = 'application.id') %>%
  select(application.id, org.duns)

new_duns <- projects.tbl %>%
  filter(fy >= 2009) %>%
  select(application.id, org.duns)

all_duns <- bind_rows(old_duns, new_duns)

project_orgs <- all_duns %>%
  separate(org.duns, into = as.character(c(1:20)), sep = ';', extra = 'drop') %>%
  gather(application.id) %>%
  setNames(c('application.id','count','org.duns')) %>%
  select(application.id, org.duns) %>%
  filter(org.duns != '') %>%
  mutate(org.duns = str_trim(org.duns),
         org.duns = str_replace(org.duns, '^0+', ''),
         org.duns = as.numeric(org.duns)) %>%
  arrange(application.id) %>%
  unique()

use_data(project_orgs, compress = 'xz')
use_data(org_info, compress = 'xz')
