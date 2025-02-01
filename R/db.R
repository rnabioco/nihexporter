#' Database versions of the nihexporter data
#'
#' These functions cache the data from the `nihexporter` database in
#' a local database for use in examples and vignettes. Indexes are created
#' to make joining tables on natural keys efficient.
#'
#' @keywords internal
#' @name nihexporter-db
NULL

#' @export
#' @rdname nihexporter-db
#' @param path location of sqlite database file
nihexporter_sqlite <- function(path = NULL) {
  cache_computation("nihexporter_sqlite", {
    path <- db_location(path, "nihexporter.sqlite")
    message("Caching nihexporter db at ", path)
    src <- src_sqlite(path, create = TRUE)
    copy_nihexporter(src)
  })
}

#' @export
#' @rdname nihexporter-db
#' @param dbname,... Arguments passed on to [src_postgres()]
nihexporter_postgres <- function(dbname = "nihexporter", ...) {
  cache_computation("nihexporter_postgres", {
    message("Caching nihexporter db in postgresql db ", dbname)
    copy_nihexporter(src_postgres(dbname, ...))
  })
}

#' @rdname nihexporter-db
#' @export
has_nihexporter <- function(type = c("sqlite", "postgresql"), ...) {
  if (!requireNamespace("nihexporter", quietly = TRUE)) return(FALSE)

  type <- match.arg(type)

  succeeds(
    switch(
      type,
      sqlite = nihexporter_sqlite(...),
      quiet = TRUE,
      postgres = nihexporter_postgres(...),
      quiet = TRUE
    )
  )
}

#' @export
#' @rdname nihexporter-db
copy_nihexporter <- function(src, ...) {
  all <- utils::data(package = "nihexporter")$results[, 3]
  unique_index <- list(
    project_io = list("project.num")
  )
  index <- list(
    project_pis = list("pi.id"),
    projects = list("project.num", "application.id"),
    patents = list("project.num", "patent.id"),
    org_info = list("org.duns"),
    publinks = list("pmid", "project.num"),
    project_orgs = list("application.id", "org.duns"),
    publications = list("pmid"),
    clinical_studies = list("project.num")
  )

  tables <- setdiff(all, src_tbls(src))

  # Create missing tables
  for (table in tables) {
    df <- getExportedValue("nihexporter", table)
    message("Creating table: ", table)

    copy_to(
      src,
      df,
      table,
      unique_indexes = unique_index[[table]],
      indexes = index[[table]],
      temporary = FALSE
    )
  }
  src
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

succeeds <- function(x, quiet = FALSE) {
  tryCatch(
    {
      x
      TRUE
    },
    error = function(e) {
      if (!quiet) message("Error: ", e$message)
      FALSE
    }
  )
}

compact <- function(x) Filter(Negate(is.null), x)
