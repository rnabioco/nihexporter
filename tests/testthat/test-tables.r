context('table integrity')

test_that('table rows are unique', {
  skip('currently failing')
  expect_equal(nrow(org_info), nrow(unique(org_info)))
  expect_equal(nrow(patents), nrow(unique(patents)))
  expect_equal(nrow(project_io), nrow(unique(project_io)))
  expect_equal(nrow(project_orgs), nrow(unique(project_orgs)))
  expect_equal(nrow(project_pis), nrow(unique(project_pis)))
  expect_equal(nrow(projects), nrow(unique(projects)))
  expect_equal(nrow(publications), nrow(unique(publications)))
  expect_equal(nrow(publinks), nrow(unique(publinks)))
})
