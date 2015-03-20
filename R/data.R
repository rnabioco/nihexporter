#'
#' projects
#'
#' @format A data frame with 11 variables:
#' \describe{
#' \item{\code{project.num}}{core project number, e.g. R01GM1234556}
#' \item{\code{activity}}{activity code, e.g. R01}
#' \item{\code{suffix}}{'A'mended and 'S'upplmental + serial number}
#' \item{\code{institute}}{administering institute}
#' \item{\code{fiscal.year}}{year of funding}
#' \item{\code{org.duns}}{DUNS number}
#' \item{\code{project.start}}{in ymd format}
#' \item{\code{project.end}}{in ymd format}
#' \item{\code{study.section}}{3 letter code}
#" \item{\code{total.cost}}{total (direct + indirect) for fiscal year}
#' } 
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=4&index=0}
"projects"

#' project.pis
#'
#' @format A data frame with 2 variables: \code{project.num} and \code{pi.id}
#'
#' The pi.id is a unique identifier that can be used to identify specific
#' PIs in NIH REPORTER.
#' 
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=4&index=0}
#'
"project.pis"

#' project.orgs
#'
#' @format A data frame with 4 variables: \code{org.duns},
#'   \code{org.city}, \code{org.state} and \code{org.name}
#'
#' The org.duns is a unique identifier that links the `project.orgs` and
#' `projects` tables 
#' 
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=4&index=0}
#'
"project.orgs"

#' publinks
#'
#' Links Pubmed IDs to Project IDs. 
#'
#' @format A data frame with two variables: \code{pmid}, \code{project.num}
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=0&index=4}
"publinks"

#' patents
#'
#' Links patent IDs to Project IDs. 
#'
#' @format A data frame with two variables: \code{patent.id}, \code{project.num}
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=0&index=3}
"patents"

#' project.output 
#'
#' Pre-computed numbers of patents and publications associated with each
#' project 
#'
#' @format A data frame with three variables: \code{project.num},
#'   \code{n.pubs} and \code{n.patents}
#'
"project.output"
