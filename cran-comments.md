## Test environments
* local OS X install, R 3.1.2
* ubuntu 12.04 (on travis-ci), R 3.1.2
* win-builder (release, unstable)

## R CMD check results
There were no ERRORs or WARNNINGS on OS X, ubuntu and win-builder release. The package currently results in an ERROR on the unstable verion; I assume this is an R-related issue but am unsure whether it needs to build cleanly on the unstable branch to be accepted

There are 3 notes:

- large files (installed size is 30.1 Mb; this is a data package).
- non-standard files (NEWS and README png)

## Downstream dependencies
