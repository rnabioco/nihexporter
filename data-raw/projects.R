## projects and project_pis tables

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

## load the FY2985-1999 funding data
col_types <- cols_only(
  APPLICATION_ID = col_integer(),
  FY = col_integer(),
  TOTAL_COST = col_double()
)

## project_pis table
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
