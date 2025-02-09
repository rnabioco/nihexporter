## projects_min table

# where do the "PRJFUNDING" files come from? TBD

# main data are in the "PRJ_C" files.
#
# the format of the projects tables is different for each year:
#
# - 1985 - 2005: 42 columns
# - 2006 - 2024: 46 columns
#
# The later years had direct and indirect costs added.
library(tidyverse)
library(here)
library(janitor)

data_dir <- here("data-raw/downloads/projects")

col_types <- cols_only(
  APPLICATION_ID = col_double(),
  ACTIVITY = col_character(),
  ADMINISTERING_IC = col_character(),
  APPLICATION_TYPE = col_double(),
  ARRA_FUNDED = col_character(),
  CORE_PROJECT_NUM = col_character(),
  # FOA_NUMBER = col_character(),
  FUNDING_MECHANISM = col_factor(),
  FY = col_factor(),
  ORG_CITY = col_character(),
  ORG_DUNS = col_character(), # leading zeros so no int
  ORG_NAME = col_character(),
  ORG_STATE = col_character(),
  ORG_DISTRICT = col_integer(),
  PI_IDS = col_character(),
  PROJECT_START = col_date(format = "%Y-%m-%d"),
  PROJECT_END = col_date(format = "%Y-%m-%d"),
  STUDY_SECTION = col_character(),
  SUFFIX = col_character(),
  TOTAL_COST = col_double(),
  DIRECT_COST_AMT = col_double(),
  INDIRECT_COST_AMT = col_double()
)

# main projects table is 2006 onward
projects_min <-
  tibble(
    path = fs::dir_ls(data_dir, glob = "*PRJ_C_*.csv"),
    csv = fs::path_file(path),
    fy = stringr::str_extract(csv, "[0-9]+")
  ) |>
    filter(fy >= 2006) |>
    mutate(
      tbl = purrr::map(path, ~read_csv(.x, col_types = col_types))
    ) |>
    select(tbl) |>
    unnest(tbl) |>
    janitor::clean_names() |>
    select(-pi_ids) |>
    rename(
      project_num = core_project_num,
      fiscal_year = fy,
      institute = administering_ic
    ) |>
    filter(!is.na(project_num) & !is.na(total_cost)) |>
    filter(!grepl("-", project_num)) |>
    filter(institute %in% nih_institutes) |>
    mutate(
      across(
        c(
          project_num,
          institute,
          activity,
          application_type,
          arra_funded,
          study_section,
          suffix,
          org_state,
          org_district
        ),
        as.factor
      ),
      fy_cost = as.double(total_cost)
    ) |>
    select(
      activity,
      institute,
      project_num,
      fiscal_year,
      project_start,
      project_end,
      starts_with("org"),
      ends_with("amt"),
      fy_cost
    )

use_data(projects_min, compress = "xz", overwrite = TRUE)
