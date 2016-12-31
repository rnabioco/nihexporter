library(dplyr)
library(stringr)
library(readr)

path = 'data-raw//CLINICAL_STUDIES'
csvfiles <- dir(path, pattern = '\\.csv', full.names = TRUE)
tables <- lapply(csvfiles, read_csv)

clinical_studies <- bind_rows(tables)
clinical_studies.tbl <- tbl_df(clinical_studies)

names(clinical_studies.tbl) <- names(clinical_studies.tbl) %>%
  str_to_lower() %>%
  str_replace_all('_','.') %>%
  str_replace_all(' ','.')

clinical_studies <- clinical_studies.tbl %>%
  rename(project.num = core.project.number,
         trial.id = clinicaltrials.gov.id) %>%
  select(project.num, trial.id, study.status) %>%
  mutate(study.status = as.factor(study.status)) %>%
  arrange(project.num)

save(clinical_studies, file = 'data/clinical_studies.rdata', compress = 'xz')
