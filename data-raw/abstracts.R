# parse and tokenize abstracts

# https://juliasilge.com/blog/animal-crossing/
# https://textrecipes.tidymodels.org/articles/cookbook---using-more-complex-recipes-involving-text.html

library(tidymodels)
library(textrecipes)
library(here)

source("data-raw/common.R")

path <- here("data-raw/downloads/abstracts")

col_types <- cols_only(
  APPLICATION_ID = col_double(),
  ABSTRACT_TEXT = col_character(),
)

abstracts_raw_tbl <-
  load_tbl(path, col_types) |>
    left_join(projects, by = "application_id") |>
    select(application_id, fiscal_year, institute, abstract_text) |>
    na.omit() |>
    unique()

# test tokenize
