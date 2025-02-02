# rcr() returns expected

    Code
      res
    Output
      # A tibble: 2 x 25
           pmid  year title authors journal is_research_article relative_citation_ra~1
          <int> <int> <chr> <chr>   <chr>   <chr>                                <dbl>
      1  2.50e7  2014 High~ D Suzi~ Genome~ Yes                                   2.17
      2  2.60e7  2015 Glob~ Sally ~ Nuclei~ Yes                                   0.94
      # i abbreviated name: 1: relative_citation_ratio
      # i 18 more variables: nih_percentile <dbl>, human <dbl>, animal <dbl>,
      #   molecular_cellular <dbl>, apt <dbl>, is_clinical <chr>,
      #   citation_count <int>, citations_per_year <dbl>,
      #   expected_citations_per_year <dbl>, field_citation_rate <dbl>,
      #   provisional <chr>, x_coord <dbl>, y_coord <dbl>, cited_by_clin <lgl>,
      #   cited_by <list>, references <list>, doi <chr>, last_modified <chr>

