# parse and tokenize abstracts

library(tidyverse)
library(tidytext)
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
    select(activity, fiscal_year, institute, abstract_text) |>
    # extramural only
    filter(!str_detect(activity, "^Z")) |>
    na.omit() |>
    unique()

data(stop_words)
custom_stop_words <- tibble(
  word = c(
    # generic to abstracts
    "research",
    "specific",
    "studies",
    "aim",
    # meaningless annotations
    "description",
    "unreadable"
  )
)

tokenize_words <- function(df) {
  unnest_tokens(df, input = abstract_text, output = word) |>
    # remove words that are numbers
    filter(!str_detect(word, "^[0-9]*$")) |>
    anti_join(stop_words) |>
    anti_join(custom_stop_words) |>
    count(activity, fiscal_year, institute, word, sort = TRUE) |>
    filter(n >= 10)
}

df_splits <- group_by(abstracts_raw_tbl, fiscal_year, institute) |>
  group_split()

# df_splits <- df_splits[1:10]

library(furrr)
library(progressr)
plan(multisession, workers = 12)
with_progress({
  p <- progressor(steps = length(df_splits))

  abstract_words <- future_map_dfr(
    df_splits,
    ~{
      p()
      tokenize_words(.x)
    }
  )
})

usethis::use_data(abstract_words, compress = "xz", overwrite = TRUE)
