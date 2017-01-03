#' load and parse clinical studies files

source('data-raw/common.R')

path = 'data-raw//CLINICAL_STUDIES'
clinical_studies.tbl <- load_tbl(path)

clinical_studies <- clinical_studies.tbl %>%
  rename(project.num = core.project.number,
         trial.id = clinicaltrials.gov.id) %>%
  select(project.num, trial.id, study.status) %>%
  mutate(study.status = as.factor(study.status)) %>%
  arrange(project.num)

use_data(clinical_studies, compress = 'xz')
