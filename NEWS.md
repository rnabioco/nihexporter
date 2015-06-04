# nihexporter, version 0.7 (unreleased)

## Major

- `org.duns` in `project_orgs` table is corrected (thanks EXPORTER folks)
- only projects associted with `nih.institues` are in the `projects` table, so no need to filter by `nih.institutes`
- added `application.type` and `arra.funded` to `projects` table
- add CITATION file

## Minor

- refactor data loading 

# nihexporter, version 0.6.1

## Minor

- added missing `project.cost` to `project.io` table 

# nihexporter, version 0.6

## Major

- renamed `project_output` to `project_io`

- added `publications` table 

# nihexporter, version 0.5

## Major

- identified *major* issue with organization DUNS numbers in the PROJECTS
  table. Emailed NIH EXPORTER via the website and asked them to fix.

- added `project_output` table with pre-computed values for grants

## Minor

- removed dots from table names
  
  + rename `project.orgs` to `project_orgs`
  + rename `project.pis` to `project_pis`

# nihexporter, version 0.4

## Major 

- added `patents` table
- updated vignette with `patents` example

# nihexporter, version 0.3

## Major

- recompressed rdata files to be much smaller
- new grant_productivity vignette
- added nih.institutes variable for quick filtering with %in%

## Minor

