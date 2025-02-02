test_that("rcr() returns expected", {
  pmids <- c(26001965, 25015380)
  res <- rcr(pmids)
  expect_snapshot(res)
})

test_that("too many PMIDs throws an error", {
  # max is currenty 1000
  fake <- 1:1001
  expect_error(rcr(fake))
})
