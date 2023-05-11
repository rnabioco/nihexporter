#' common functions

library(tidyverse)
library(usethis)
library(devtools)

# provides `nih.institutes`
source('R/vars.R')

#' load CSV files from path and return as formatted tbl
#'
load_tbl <- function(path, col_types = NULL) {

    csvfiles <- dir(path, pattern = '\\.csv', full.names = TRUE)
    tables <- lapply(csvfiles, function(x) read_csv(x, col_types = col_types))
    raw_tbl <- tbl_df(bind_rows(tables))

    names(raw_tbl) <- names(raw_tbl) %>%
      str_to_lower() %>%
      str_replace_all('_','.') %>%
      str_replace_all(' ','.')

    raw_tbl
}


