#' Cache and retrieve an \code{src_sqlite} of the nihexporter database.
#'
#' This creates a database using data from the nihexporter
#' data source, provided
#' through the \pkg{nihexporter} package by Jay Hesselberth.
#' See the documentation
#' for that package for documentation of the inidividual tables.
#'
#' @param ... Arguments passed to \code{src} on first
#'   load. For mysql and postgresql, the defaults assume you have a local
#'   server with \code{nihexporter} database already created. For bigquery,
#'   it assumes you have read/write access to a project called
#'   \code{Sys.getenv("BIGQUERY_PROJECT")}
#'
#'   For \code{nihexporter_srcs}, character vector of names giving srcs to generate.
#' @param quiet if \code{TRUE}, suppress messages about databases failing to
#'   connect.
#' @param type src type.
#' @examples
#' # Connect to a local sqlite database, if already created
#' if (require("RSQLite") && has_nihexporter("sqlite")) {
#'   nihexporter_sqlite()
#'   projects <- tbl(nihexporter_sqlite(), "projects")
#'   projects
#' }
#'
#' # Connect to a local postgres database with nihexporter database, if available
#' if (require("RPostgreSQL") && has_nihexporter("postgres")) {
#'   nihexporter_postgres()
#'   projects <- tbl(nihexporter_postgres(), "projects")
#' }
#' @name nihexporter
NULL

#' @export
#' @rdname nihexporter
nihexporter_sqlite <- function() {
  cache_nihexporter("sqlite", create = TRUE)
}

#' @export
#' @rdname nihexporter
nihexporter_postgres <- function(...) cache_nihexporter("postgres", ...)

#' @export
#' @rdname nihexporter
nihexporter_mysql <- function(...) cache_nihexporter("mysql", ...)

#' @export
#' @rdname nihexporter
nihexporter_monetdb <- function(...) cache_nihexporter("monetdb", ...)

#' @export
#' @rdname nihexporter
nihexporter_df <- function() {
  src_df("nihexporter")
}

#' @export
#' @rdname nihexporter
nihexporter_dt <- function() {
  src_dt("nihexporter")
}

#' @export
#' @rdname nihexporter
nihexporter_bigquery <- function(...) {
  if (is_cached("nihexporter_bigquery")) return(get_cache("nihexporter_bigquery"))
  
  src <- nihexporter_src("bigquery", ...)
  tables <- setdiff(nihexporter_tables(), src_tbls(src))
  
  jobs <- vector("list", length(tables))
  names(jobs) <- tables
  
  # Submit all upload jobs
  for(table in tables) {
    df <- getExportedValue("nihexporter", table)
    
    if (!quiet) message("Creating table ", table)
    jobs[[table]] <- insert_upload_job(src$con$project, src$con$dataset, table,
                                       df, billing = src$con$billing)
  }
  
  # Wait for all results
  all_ok <- TRUE
  for (table in names(jobs)) {
    message("Waiting for ", table)
    all_ok <- all_ok && succeeds(wait_for(jobs[[table]]))
  }
  
  if (!all_ok) stop("Load failed", call. = FALSE)
  
  set_cache("nihexporter_bigquery", src)
}

cache_nihexporter <- function(type, ...) {
  cache_name <- paste0("nihexporter_", type)
  if (is_cached(cache_name)) return(get_cache(cache_name))
  
  src <- nihexporter_src(type, ...)
  tables <- setdiff(nihexporter_tables(), src_tbls(src))
  
  # Create missing tables
  for(table in tables) {
    df <- getExportedValue("nihexporter", table)
    message("Creating table: ", table)
    
    ids <- as.list(names(df)[grepl("ID$", names(df))])
    copy_to(src, df, table, indexes = ids, temporary = FALSE)
  }
  
  set_cache(cache_name, src)
}

#' @rdname nihexporter
#' @export
has_nihexporter <- function(type, ...) {
  if (!requireNamespace("nihexporter", quietly = TRUE)) return(FALSE)
  if (missing(type)) return(TRUE)
  
  succeeds(nihexporter_src(type, ...), quiet = TRUE)
}

nihexporter_src <- function(type, ...) {
  switch(type,
         df = nihexporter_df(),
         dt = nihexporter_dt(),
         sqlite = src_sqlite(db_location(filename = "nihexporter.sqlite"), ...),
         mysql = src_mysql("nihexporter", ...),
         monetdb = src_monetdb("nihexporter", ...),
         postgres = src_postgres("nihexporter", ...),
         bigquery = src_bigquery(Sys.getenv("BIGQUERY_PROJECT"), "nihexporter", ...),
         stop("Unknown src type ", type, call. = FALSE)
  )
}

#' @rdname nihexporter
#' @export
nihexporter_srcs <- function(..., quiet = NULL) {
  load_srcs(nihexporter_src, c(...), quiet = quiet)
}

succeeds <- function(x, quiet = FALSE) {
  ok <- FALSE
  try({
    force(x)
    ok <- TRUE
  }, silent = quiet)
  
  ok
}

# Get list of all non-label data frames in package
nihexporter_tables <- function() {
  tables <- data(package = "nihexporter")$results[, 3]
  tables[!grepl("Labels", tables)]
}

# Environment for caching connections etc
cache <- new.env(parent = emptyenv())

is_cached <- function(name) exists(name, envir = cache)
set_cache <- function(name, value) {
  #   message("Setting ", name, " in cache")
  assign(name, value, envir = cache)
  value
}
get_cache <- function(name) {
  #   message("Getting ", name, " from cache")
  get(name, envir = cache)
}

cache_computation <- function(name, computation) {
  if (is_cached(name)) {
    get_cache(name)
  } else {
    res <- force(computation)
    set_cache(name, res)
    res
  }
}

load_srcs <- function(f, src_names, quiet = NULL) {
  if (is.null(quiet)) {
    quiet <- !identical(Sys.getenv("NOT_CRAN"), "true")
  }
  
  
  srcs <- lapply(src_names, function(x) {
    out <- NULL
    try(out <- f(x), silent = TRUE)
    if (is.null(out) && !quiet) {
      message("Could not instantiate ", x, " src")
    }
    out
  })
  
  compact(setNames(srcs, src_names))
}

db_location <- function(path = NULL, filename) {
  if (!is.null(path)) {
    # Check that path is a directory and is writeable
    if (!file.exists(path) || !file.info(path)$isdir) {
      stop(path, " is not a directory", call. = FALSE)
    }
    if (!is_writeable(path)) stop("Can not write to ", path, call. = FALSE)
    return(file.path(path, filename))
  }
  
  pkg <- file.path(system.file("db", package = "dplyr"))
  if (is_writeable(pkg)) return(file.path(pkg, filename))
  
  tmp <- tempdir()
  if (is_writeable(tmp)) return(file.path(tmp, filename))
  
  stop("Could not find writeable location to cache db", call. = FALSE)
}

is_writeable <- function(x) {
  unname(file.access(x, 2) == 0)
}
