#' NIH EXPORTER 
#'
#' Minimal set of data provided by NIH EXPORTER describing funded biomedical research projects from 2000-2014.
#'
#' projects
#'
#' @format A data frame with 11 variables: \code{application.id}, \code{institute},
#'   \code{activity}, \code{project.num}, \code{fiscal.year},
#'   \code{org.duns}, \code{suffix}, \code{project.start},
#'   \code{project.end}, \code{study.section}, \code{total.cost} 
#'
#' For further details, see \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=4&index=0}
"projects"

#' project.pis
#'
#' @format A data frame with 2 variables: \code{project.num} and \code{pi.id}
#'
#' The pi.id is a unique identifier that can be used to identify specific
#' PIs in NIH REPORTER.
"project.pis"

#' publinks
#'
#' Links Pubmed IDs to Project IDs. 
#'
#' @format A data frame with two variables: \code{pmid}, \code{project.num}
#'
#' For further details, see \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=0&index=4}
"publinks"

