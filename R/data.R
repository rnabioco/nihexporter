#' projects
#'
#' @format A data frame with 11 variables: \code{application.id}, \code{institute},
#'   \code{activity}, \code{project.num}, \code{fiscal.year},
#'   \code{org.duns}, \code{suffix}, \code{project.start},
#'   \code{project.end}, \code{study.section}, \code{total.cost} 
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
 
