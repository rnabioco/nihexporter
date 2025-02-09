# nihexporter 0.11.0

* New `abstract_words` table containing tokenized words for project abstracts.

* New `projects_min` table, which contains a minimal subset of projects data from 2006-2024,
  with both direct and indirect costs (2006 was the first year IC amounts were published).

* Fixed date parsing in `projects`.

# nihexporter 0.10.0

* Update tables through FY 2024.

# nihexporter 0.9

## Major changes

- Reload `projects` data. `fy.cost` now spans 1985-2021.

- Some columns in the `projects` table updated to `date` types

- Recalculate `project_io` table.

- New `clinical_studies` table.

- Removed `project_orgs` and `org_info` tables, now in main `projects` table.

- `rcr` values added to the `publications` table, and added new `rcr()` function that enables retrieval of [RCR values](https://icite.od.nih.gov/stats) for specific PMIDs.

- remove duplicate rows and `NA`s from `project_pis` table.

## Minor changes

- Added pkgdown documentation

- removed a few unused columns (`journal.title.abbr` from `publications`) from tables to minimize package size.

- Refactored data loading scripts

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
