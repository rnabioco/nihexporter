context('rcr')

test_that("rcr() returns expected", {
  pmids <- c(26001965, 25015380)
  res <- rcr(pmids)
  expect_equal(res$relative_citation_ratio, c(2.16, 0.94))
})

test_that('too many PMIDs throws an error', {
  # max is currenty 1000
  fake <- 1:1001
  expect_error(rcr(fake))
})

