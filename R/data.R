#' NIH EXPORTER 
#'
#' Minimal set of data provided by NIH EXPORTER describing funded biomedical research projects from 1985-2014.
#'
#' @format A data frame with five variables: \code{year}, \code{sex},
#'   \code{name}, \code{n} and \code{prop} (\code{n} divided by total number
#'   of applicants in that year).
#' For further details, see \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=4&index=0}
"projects"

#' pi.names 
#'
#' The SSA baby names data comes from social security number (SSN) applications.
#' SSA cards were first issued in 1936, but were only needed for people with
#' an income. In 1986, the law changed effectively requiring all children to
#' get an SSN at birth.
#'
#' @format A data frame with 3 variables: \code{year}, \code{sex} and
#'   \code{applicants}
"pi.names"

#' Publinks
#'
#' Links Pubmed IDs to Project IDs. 
#'
#' @format A data frame with two variables: \code{pmid}, \code{project.num}
#'
#' For further details, see \url{http://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=0&index=4}

#'
"publinks"

