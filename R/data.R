#'
#' projects
#'
#' @format A data frame with 13 variables:
#' \describe{
#' \item{\code{application.id}}{unique ID for the EXPORTER database}
#' \item{\code{project.num}}{core project number, e.g. R01GM1234556}
#' \item{\code{activity}}{activity code, e.g. R01}
#' \item{\code{application.type}}{one-digit code to identify type of application funded}
#' \item{\code{arra.funded}}{'Y' indicates ARRA funded, 'N' and 'NA' are not ARRA funded}
#' \item{\code{suffix}}{'A'mended and 'S'upplmental + serial number}
#' \item{\code{institute}}{administering institute}
#' \item{\code{fiscal.year}}{year of funding}
#' \item{\code{foa.number}}{parent FOA}
#' \item{\code{project.start}}{in ymd format}
#' \item{\code{project.end}}{in ymd format}
#' \item{\code{study.section}}{3 letter code}
#' \item{\code{fy.cost}}{total (direct + indirect) for fiscal year}
#' } 
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=4&index=0}
"projects"

#' project_pis
#'
#' @format A data frame with 2 variables: \code{project.num} and \code{pi.id}
#'
#' The pi.id is a unique identifier that can be used to identify specific
#' PIs in NIH REPORTER.
#' 
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=4&index=0}
#'
"project_pis"

#' org_info
#'
#' @format A data frame with 4 variables: \code{org.duns},
#'   \code{org.city}, \code{org.state} and \code{org.name}
#'
#' The org.duns is a unique identifier that links the `org_info` and
#' `project_orgs` tables.
#' 
#' Note that there are potential issues with this table as the DUNS reporting in the NIH EXPORTER is not accurate for years 2000-2008.
#' 
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=4&index=0}
#'
"org_info"

#' project_orgs
#'
#' @format A data frame with 2 variables: \code{org.duns} and \code{application.id} used to link specific applications to organizations
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=4&index=0}
#'
"project_orgs"

#' publinks
#'
#' Links Pubmed IDs to Project IDs. 
#'
#' @format A data frame with two variables: \code{pmid}, \code{project.num}
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=0&index=4}
"publinks"

#' publications
#'
#' Information about specific publications
#'
#' @format A data frame with two variables: \code{pmid}, \code{pmc.id},
#'  \code{journal.title.abbr}, \code{pub.year}
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=0&index=4}
"publications"

#' patents
#'
#' Links patent IDs to Project IDs. 
#'
#' @format A data frame with two variables: \code{patent.id}, \code{project.num}
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=0&index=3}
"patents"

#' project_io
#'
#' Pre-computed project.cost, number of patents and publications associated with each
#' project 
#'
#' @format A data frame with four variables: \code{project.num},
#'   \code{n.pubs}, \code{n.patents} and \code{total.cost}
#'
#' @source pre-computed from \code{projects} table
"project_io"
