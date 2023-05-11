#' create and save the `project_io` table

source('data-raw/common.R')

project_costs <- projects |>
  filter(institute %in% nih.institutes) |>
  select(project_num, fy_cost) |>
  group_by(project_num) |>
  summarize(total_cost = sum(fy_cost, na.rm = TRUE))

pub_output <- project_costs |>
  left_join(publinks) |>
  group_by(project_num) |>
  summarize(n_pubs = n())

patent_output <- project_costs |>
  left_join(patents) |>
  group_by(project_num) |>
  summarize(n_patents = n())

project_io <- pub_output |>
  inner_join(patent_output) |>
  left_join(project_costs) |>
  filter(project_num != '') |>
  filter(!grepl('-', project_num)) |>
  arrange(project_num)

use_data(project_io, compress = 'xz', overwrite = TRUE)
