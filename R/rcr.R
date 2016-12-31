#' Retrieve Relative Citation Ratio (RCR) for PubMed IDs.
#'
#' @param pmids vector of PubMed IDs to retrieve (max of 1000 at a time)
#'
#' @return a data_frame the following variables:
#' \describe{
#' \item{\code{pmid}}{PubMed ID}
#' \item{\code{authors}}{publication authors}
#' \item{\code{citation_count}}{total citations}
#' \item{\code{citations_per_year}}{mean citations per year}
#' \item{\code{expected_citations_per_year}}{estimated}
#' \item{\code{field_citation_rate}}{rate relative to field}
#' \item{\code{is_research_article}}{boolean}
#' \item{\code{journal}}{journal name abbr.}
#' \item{\code{nih_percentile}}{percentile}
#' \item{\code{relative_citation_ratio}}{RCR}
#' \item{\code{title}}{article title}
#' \item{\code{year}}{publication year}
#' }
#'
#' @import httr
#' @import jsonlite
#' @import dplyr
#'
#' @seealso \url{https://icite.od.nih.gov/api}
#'
#' @examples
#' pmids <- c(26001965, 25015380)
#' rcr(pmids)
#'
#' @export
rcr <- function(pmids) {

  max_pmids <- 1000
  if(length(pmids) > max_pmids)
    stop('maximum pubmed ids exceeded', call. = FALSE)

  ## icite url
  url <- 'https://icite.od.nih.gov'
  path <- 'api/pubs'
  query <- list('pmids' = paste0(pmids, collapse = ','))

  url_built <- modify_url(url, path = path, query = query)

  raw <- GET(url_built) %>% content(., 'text') %>% fromJSON(.)

  as_data_frame(raw$data)
}

