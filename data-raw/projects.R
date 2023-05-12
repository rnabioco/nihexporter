## projects and project_pis tables

source('data-raw/common.R')

path <- here('data-raw/downloads/projects')

col_types <- cols_only(
   APPLICATION_ID    = col_double(),
   ACTIVITY          = col_character(),
   ADMINISTERING_IC  = col_character(),
   APPLICATION_TYPE  = col_double(),
   ARRA_FUNDED       = col_character(),
   CORE_PROJECT_NUM  = col_character(),
   FOA_NUMBER        = col_character(),
   FUNDING_MECHANISM = col_factor(),
   FY                = col_factor(),
   ORG_CITY          = col_character(),
   ORG_DUNS          = col_character(), # leading zeros so no int
   ORG_NAME          = col_character(),
   ORG_STATE         = col_character(),
   ORG_DISTRICT      = col_integer(),
   PI_IDS            = col_character(),
   PROJECT_START     = col_date(format="%m/%d/%Y"),
   PROJECT_END       = col_date(format="%m/%d/%Y"),
   STUDY_SECTION     = col_character(),
   SUFFIX            = col_character(),
   TOTAL_COST        = col_double()
)

projects_tbl <- load_tbl(path, col_types)

projects <- projects_tbl |>
  # select(application_id,
  #        administering_ic, activity,
  #        application_type, arra_funded,
  #        core_project_num, foa_number,
  #        fy, project_start, project_end,
  #        study_section, suffix, total_cost) |>
  select(-pi_ids) |>
  rename(project_num = core_project_num,
         fiscal_year = fy,
         institute = administering_ic) |>
  filter(!is.na(project_num) & !is.na(total_cost)) |>
  filter(!grepl('-', project_num)) |>
  filter(institute %in% nih_institutes) |>
  mutate(institute = as.factor(institute),
         activity = as.factor(activity),
         application_type = as.factor(application_type),
         arra_funded = as.factor(arra_funded),
         foa_number = as.factor(foa_number),
         study_section = as.factor(study_section),
         suffix = as.factor(suffix),
         org_state = as.factor(org_state),
         org_district = as.factor(org_district),
         fy_cost = as.double(total_cost)) |>
  select(-total_cost)

use_data(projects, compress = 'xz', overwrite = TRUE)

## project_pis table
project_pis <- projects_tbl |>
  select(core_project_num, pi_ids, administering_ic) |>
  rename(project_num = core_project_num,
         institute = administering_ic) |>
  filter(institute %in% nih_institutes) |>
  filter(!grepl('-', project_num)) |>
  select(project_num, pi_ids) |>
  separate_longer_delim(pi_ids, delim = ';') |>
  filter(pi_ids != '') |>
  rename(pi_id = pi_ids) |>
  mutate(pi_id = str_trim(pi_id) |> str_replace_all( ' \\(contact\\)', '')) |>
  na.omit() |> unique() |>
  arrange(project_num)

use_data(project_pis, compress = 'xz', overwrite = TRUE)
