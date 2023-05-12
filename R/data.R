#' Project information.
#'
#' @format A data frame with 13 variables:
#' \describe{
#' \item{`application.id`}{unique ID for the EXPORTER database}
#' \item{`project.num`}{core project number, e.g. R01GM1234556}
#' \item{`activity`}{activity code, e.g. R01}
#' \item{`application.type`}{one-digit code to identify type of application funded}
#' \item{`arra.funded`}{'Y' indicates ARRA funded, 'N' and 'NA' are not ARRA funded}
#' \item{`suffix`}{'A'mended and 'S'upplmental + serial number}
#' \item{`institute`}{administering institute}
#' \item{`fiscal.year`}{year of funding}
#' \item{`foa.number`}{parent FOA}
#' \item{`project.start`}{in ymd format}
#' \item{`project.end`}{in ymd format}
#' \item{`study.section`}{3 letter code}
#' \item{`fy.cost`}{total (direct + indirect) for fiscal year}
#' }
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=3&index=0}
"projects"

#' Principal investigators.
#'
#' @format A data frame with 2 variables: `project.num` and `pi.id`
#'
#' The `pi.id` is a unique identifier that can be used to identify specific
#' principal investigators in NIH REPORTER.
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=3&index=0}
#'
"project_pis"

#' Table linking PubMed IDs to project IDs.
#'
#' @format A data frame with two variables: `pmid`, `project.num`
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=2&index=5}
"publinks"

#' Publication information.
#'
#' @format A data frame with 4 variables: `pmid`, `pmc.id`,
#'   `pub.year`, `rcr`
#'
#' @note `rcr` values change over time. Values in this table were
#'   downloaded on 31 Dec 2016. Use [rcr()] to obtain current
#'   values for select `pmid` values.
#'
#' @source \url{https://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=4&index=2}
#' @source \url{https://icite.od.nih.gov/}
"publications"

#' Table linking patent IDs to project IDs.
#'
#' @format A data frame with two variables: `patent.id`, `project.num`
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=5&index=3}
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

