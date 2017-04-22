# nihexporter 0.9.0.9000

## Major changes
 
- Reload `projects` data. `fy.cost` now spans 1985-2016. [TODO]

- Recalculate `project_io` table. [TODO]

- New `clinical_studies` table.

- `rcr` values added to the `publications` table, and added new `rcr()` function that enables retrieval of [RCR values](https://icite.od.nih.gov/stats) for specific PMIDs.

- remove duplicate rows and `NA`s from `project_pis` table.

## Minor changes

- Added pkgdown documentation

- removed a few unused columns (`journal.title.abbr` from `publications`) from tables to minimize package size.

# nihexporter 0.8

- update to FY 2015
- small fixes for tidyr::separate, need characters for `into` arg
- add script for downloading DUNS patch files

# nihexporter 0.7

## Major

- `org.duns` in `project_orgs` table is corrected (thanks EXPORTER folks)
- only projects associted with `nih.institues` are in the `projects` table, so no need to filter by `nih.institutes`
- added `application.type` and `arra.funded` to `projects` table
- add CITATION file

## Minor

- refactor data loading 

# nihexporter 0.6.1

## Minor

- added missing `project.cost` to `project.io` table 

# nihexporter 0.6

## Major

- renamed `project_output` to `project_io`

- added `publications` table 

# nihexporter 0.5

## Major

- identified *major* issue with organization DUNS numbers in the PROJECTS
  table. Emailed NIH EXPORTER via the website and asked them to fix.

- added `project_output` table with pre-computed values for grants

## Minor

- removed dots from table names
  
  + rename `project.orgs` to `project_orgs`
  + rename `project.pis` to `project_pis`

# nihexporter 0.4

## Major 

- added `patents` table
- updated vignette with `patents` example

# nihexporter 0.3

## Major

- recompressed rdata files to be much smaller
- new grant_productivity vignette
- added nih.institutes variable for quick filtering with %in%

## Minor
