#' common functions

library(tidyverse)
library(usethis)
library(devtools)
library(here)
library(janitor)
library(fs)

# provides `nih.institutes`
source("R/vars.R")

#' load CSV files from path and return as formatted tbl
#'
load_tbl <- function(path, col_types = NULL) {
  csvfiles <- dir(path, pattern = "\\.csv", full.names = TRUE)
  tables <- lapply(
    csvfiles,
    function(x) readr::read_csv(x, col_types = col_types)
  )
  raw_tbl <- tibble(bind_rows(tables))

  janitor::clean_names(raw_tbl)
}

load_tbl_nested <- function(path) {
  tibble(
    path = fs::dir_ls(path, glob = "*.csv"),
    csv = fs::path_file(path),
    fy = as.integer(stringr::str_extract(csv, "[0-9]+")),
    tbl = purrr::map(path, ~read_csv(.x))
  ) |>
    select(fy, csv, tbl)
}
