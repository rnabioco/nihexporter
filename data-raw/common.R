#' common functions

library(tidyverse)
library(usethis)
library(devtools)
library(here)
library(janitor)

# provides `nih.institutes`
source("R/vars.R")

#' load CSV files from path and return as formatted tbl
#'
load_tbl <- function(path, col_types = NULL) {
  csvfiles <- dir(path, pattern = "\\.csv", full.names = TRUE)
  tables <- lapply(csvfiles, function(x) read_csv(x, col_types = col_types))
  raw_tbl <- tibble(bind_rows(tables))

  janitor::clean_names(raw_tbl)
}
