#' Project information.
#'
#' @format A data frame with 19 variables
#'
#' @source \url{https://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=3&index=0}
"projects"

#' Principal investigators.
#'
#' @format A data frame with 2 variables: `project.num` and `pi.id`
#'
#' The `pi.id` is a unique identifier that can be used to identify specific
#' principal investigators in NIH REPORTER.
#'
#' @source \url{https://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=3&index=0}
#'
"project_pis"

#' Table linking PubMed IDs to project IDs.
#'
#' @format A data frame with two variables: `pmid`, `project.num`
#'
#' @source \url{https://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=2&index=5}
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
#' @source \url{https://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=4&index=2}
#' @source \url{https://icite.od.nih.gov/}
"publications"

#' Table linking patent IDs to project IDs.
#'
#' @format A data frame with two variables: `patent.id`, `project.num`
#'
#' @source \url{https://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=5&index=3}
"patents"

#' Clinical trial information.
#'
#' @format A data frame with three variables: `project.num`, `trial.id` and `study.status`
#'
#' @source \url{https://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=5&index=4}
"clinical_studies"

#' Pre-computed total costs, number of patents and publications per project.
#'
#' @format A data frame with four variables: `project.num`,
#'   `n.pubs`, `n.patents` and `total.cost`
#'
#' @source Computed from \link{projects} table.
"project_io"

