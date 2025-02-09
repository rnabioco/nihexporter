#' Project information.
#'
#' @format A data frame with 19 variables
#'
#' @source \url{https://reporter.nih.gov/exporter/projects}
"projects"

#' A minimum set of project information from 2006-2024.
#'
#' @format A data frame with 14 variables
#'
#' @source \url{https://reporter.nih.gov/exporter/projects}
"projects_min"

#' Principal investigators.
#'
#' @format A data frame with 2 variables: `project.num` and `pi.id`
#'
#' The `pi.id` is a unique identifier that can be used to identify specific
#' principal investigators in NIH REPORTER.
#'
#' @source \url{https://reporter.nih.gov/exporter/projects}
#'
"project_pis"

#' Table linking PubMed IDs to project IDs.
#'
#' @format A data frame with two variables: `pmid`, `project.num`
#'
#' @source \url{https://reporter.nih.gov/exporter/linktables}
"publinks"

#' Publication information.
#'
#' @format A data frame with 4 variables: `pmid`, `pmc.id`,
#'   `pub.year`, `rcr`
#'
#' @note `rcr` values change over time. Values in this table were
#'   downloaded on 11 May 2023. Use [rcr()] to obtain current
#'   values for select `pmid` values.
#'
#' @source \url{https://reporter.nih.gov/exporter/publications}
#' @source \url{https://icite.od.nih.gov/}
"publications"

#' Table linking patent IDs to project IDs.
#'
#' @format A data frame with two variables: `patent.id`, `project.num`
#'
#' @source \url{https://reporter.nih.gov/exporter/patents}
"patents"

#' Clinical trial information.
#'
#' @format A data frame with three variables: `project.num`, `trial.id` and `study.status`
#'
#' @source \url{https://reporter.nih.gov/exporter/clinicalstudies}
"clinical_studies"

#' Pre-computed total costs, number of patents and publications per project.
#'
#' @format A data frame with four variables: `project.num`,
#'   `n.pubs`, `n.patents` and `total.cost`
#'
#' @source Computed from \link{projects} table.
"project_io"

#' Tokenized words from abstracts.
#'
#' @format A tibble with five variables: `activity`, `fiscal_year`, `institute`, `word`, `n`.
#'
#' @source \url{https://reporter.nih.gov/exporter/abstracts}
"abstract_words"
