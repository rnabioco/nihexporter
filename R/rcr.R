#' Retrieve Relative Citation Ratio (RCR) for PubMed IDs.
#'
#' @param pmids vector of PubMed IDs to retrieve (max of 1000 at a time)
#'
#' @return a data_frame the following variables:
#' \describe{
#' \item{`pmid`}{PubMed ID}
#' \item{`authors`}{publication authors}
#' \item{`citation_count`}{total citations}
#' \item{`citations_per_year`}{mean citations per year}
#' \item{`expected_citations_per_year`}{estimated}
#' \item{`field_citation_rate`}{rate relative to field}
#' \item{`is_research_article`}{boolean}
#' \item{`journal`}{journal name abbr.}
#' \item{`nih_percentile`}{percentile}
#' \item{`relative_citation_ratio`}{RCR}
#' \item{`title`}{article title}
#' \item{`year`}{publication year}
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

  url_built <- httr::modify_url(url, path = path, query = query)

  raw <- httr::GET(url_built) %>%
    httr::content(., 'text') %>%
    jsonlite::fromJSON(.)

  as_data_frame(raw$data)
}

