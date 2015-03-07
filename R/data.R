#' NIH EXPORTER 
#'
#' Minimal set of data provided by NIH EXPORTER describing funded biomedical research projects from 1985-2014.
#'
#' projects
#'
#' @format A data frame with nine variables: \code{application.id}, \code{institute},
#'   \code{activity}, \code{project.num}, \code{fiscal.year}, \code{project.start},
#'   \code{project.end}, \code{study.section}, \code{total.cost} 
#'
#' For further details, see \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=4&index=0}
"projects"

#' publinks
#'
#' Links Pubmed IDs to Project IDs. 
#'
#' @format A data frame with two variables: \code{pmid}, \code{project.num}
#'
#' For further details, see \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=0&index=4}
"publinks"

