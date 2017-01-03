# projects table
#' load PROJECTS CSV files and create these tables:
#' - projects
#' - project_orgs
#' - project_pis
#' - org_info

source('data-raw/common.R')

path <- 'data-raw//PROJECTS'
col_types <- cols_only(
  APPLICATION_ID    = col_integer(),
  ACTIVITY          = col_character(),
  ADMINISTERING_IC  = col_character(),
  APPLICATION_TYPE  = col_integer(),
  ARRA_FUNDED       = col_character(),
  CORE_PROJECT_NUM  = col_character(),
  FOA_NUMBER        = col_character(),
  FUNDING_MECHANISM = col_skip(),
  FY                = col_integer(),
  ORG_CITY          = col_character(),
  ORG_DUNS          = col_character(), # leading zeros so no int
  ORG_NAME          = col_character(),
  ORG_STATE         = col_character(),
  PI_IDS            = col_character(),
  PROJECT_START     = col_character(), # col_date(format="%m/%d/%Y")
  PROJECT_END       = col_character(), # col_date(format="%m/%d/%Y")
  STUDY_SECTION     = col_character(),
  SUFFIX            = col_character(),
  TOTAL_COST        = col_double()
)

projects.tbl <- load_tbl(path, col_types)

# org table - link on org.duns
org_info <- projects.tbl %>%
  # hack to remove incorrect DUNS in 2008 and prior
  filter(fy >= 2009) %>%
  select(org.city, org.state, org.duns, org.name) %>%
  filter(!is.na(org.duns)) %>%
  mutate(org.duns = str_trim(org.duns),
         org.duns = str_replace(org.duns, '^0+', ''),
         org.duns = as.numeric(org.duns),
         org.state = as.factor(org.state),
         org.city = as.factor(org.city)) %>%
  distinct() %>%
  arrange(org.duns)

use_data(org_info, compress = 'xz')

projects <- projects.tbl %>%
  select(application.id,
         administering.ic, activity,
         application.type, arra.funded,
         core.project.num, foa.number,
         fy, project.start, project.end,
         study.section, suffix, total.cost) %>%
  rename(project.num = core.project.num,
         fiscal.year = fy,
         institute = administering.ic) %>%
  filter(!is.na(project.num) & !is.na(total.cost)) %>%
  filter(!grepl('-', project.num)) %>%
  filter(institute %in% nih.institutes) %>%
  mutate(institute = as.factor(institute),
         activity = as.factor(activity),
         application.type = as.factor(application.type),
         arra.funded = as.factor(arra.funded),
         fiscal.year = as.integer(fiscal.year),
         foa.number = as.factor(foa.number),
         study.section = as.factor(study.section),
         suffix = as.factor(suffix),
         project.end = mdy(project.end),
         project.start = mdy(project.start),
         fy.cost = as.double(total.cost)) %>%
  select(-total.cost)

use_data(projects, compress = 'xz')

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

# project_pis table
project_pis <- projects.tbl %>%
  select(core.project.num, pi.ids, administering.ic) %>%
  rename(project.num = core.project.num,
         institute = administering.ic) %>%
  filter(institute %in% nih.institutes) %>%
  filter(!grepl('-', project.num)) %>%
  select(project.num, pi.ids) %>%
  separate(pi.ids, into = as.character(c(1:20)), sep = ';', extra = 'drop') %>%
  gather(project.num) %>%
  setNames(c('project.num', 'pi.num', 'pi.id')) %>%
  filter(pi.id != '' & project.num != '') %>%
  mutate(pi.id = str_extract(pi.id, '^\\d+'),
         pi.id = as.integer(pi.id)) %>%
  select(project.num, pi.id) %>%
  na.omit() %>% unique()
  arrange(project.num) %>%

use_data(project_pis, compress = 'xz')
