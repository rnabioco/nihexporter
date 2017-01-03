#' create and save the `project_io` table

source('data-raw/common.R')

project_costs <- projects %>%
  filter(institute %in% nih.institutes) %>%
  select(project.num, fy.cost) %>%
  group_by(project.num) %>%
  summarize(total.cost = sum(fy.cost, na.rm = TRUE))

pub_output <- project_costs %>%
  left_join(publinks) %>%
  group_by(project.num) %>%
  summarize(n.pubs = n())

patent_output <- project_costs %>%
  left_join(patents) %>%
  group_by(project.num) %>%
  summarize(n.patents = n())

project_io <- pub_output %>%
  inner_join(patent_output) %>%
  left_join(project_costs) %>%
  filter(project.num != '') %>%
  filter(!grepl('-', project.num)) %>%
  arrange(project.num)

use_data(project_io, compress = 'xz')
