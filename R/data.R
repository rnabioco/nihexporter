#' Project information.
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
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=3&index=0}
"projects"

#' Principal investigators.
#'
#' @format A data frame with 2 variables: \code{project.num} and \code{pi.id}
#'
#' The \code{pi.id} is a unique identifier that can be used to identify specific
#' principal investigators in NIH REPORTER.
#' 
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=3&index=0}
#'
"project_pis"

#' Organization information.
#' 
#' @format A data frame with 4 variables: \code{org.duns}, \code{org.city}, 
#'   \code{org.state} and \code{org.name}
#'   
#' @description \code{org.duns} is a unique identifier that links the \link{org_info} and 
#'   \link{project_orgs} tables.
#'   
#' @note Be wary of this table as the DUNS reporting in the NIH EXPORTER was not
#'   previously correct for years 2000-2008.
#'   
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=3&index=0}
#'   
"org_info"

#' Table linking organizations to applications.
#' 
#' @format A data frame with 2 variables: \code{org.duns} and
#'   \code{application.id} used to link specific applications to organizations
#'   
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=3&index=0}
#'   
"project_orgs"

#' Table linking PubMed IDs to project IDs.
#'
#' @format A data frame with two variables: \code{pmid}, \code{project.num}
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=2&index=5}
"publinks"

#' Publication information.
#'
#' @format A data frame with two variables: \code{pmid}, \code{pmc.id},
#'  \code{journal.title.abbr}, \code{pub.year}, \code{rcr}
#'
#' @source \url{https://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=4&index=2}
#' @source \url{https://icite.od.nih.gov/}
"publications"

#' Table linking patent IDs to project IDs.
#'
#' @format A data frame with two variables: \code{patent.id}, \code{project.num}
#'
#' @source \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=5&index=3}
"patents"

#' Clinical trial information.
#' 
#' @format A data frame with three variables: \code{project.num}, \code{trial.id} and \code{study.status}
#' 
#' @source \url{https://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=5&index=4}
"clinical_studies"

#' Pre-computed total costs, number of patents and publications per project.
#'
#' @format A data frame with four variables: \code{project.num},
#'   \code{n.pubs}, \code{n.patents} and \code{total.cost}
#'
#' @source Computed from \link{projects} table.
"project_io"
