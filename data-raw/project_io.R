# make the `project_io` table

library(dplyr)

project_costs <- projects %>%
  filter(institute %in% nih.institutes) %>%
  select(project.num, total.cost) %>%
  group_by(project.num) %>%
  summarize(project.cost = sum(total.cost, na.rm = TRUE))

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
  filter(project.num != '') %>%
  arrange(project.num)

save(project_io, file = "data/project_io.rdata", compress = "xz")
