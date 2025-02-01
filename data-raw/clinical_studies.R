#' load and parse clinical studies files

source('data-raw/common.R')

path <- here('data-raw/downloads/ClinicalStudies.csv')
clinical_studies_tbl <- read_csv(path) |>
  janitor::clean_names()

clinical_studies <- clinical_studies_tbl |>
  rename(
    project_num = core_project_number,
    trial_id = clinical_trials_gov_id
  ) |>
  select(project_num, trial_id, study_status) |>
  mutate(study_status = as_factor(study_status)) |>
  arrange(project_num)

use_data(clinical_studies, compress = 'xz', overwrite = TRUE)
