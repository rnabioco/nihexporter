context('rcr')

test_that('too many PMIDs throws an error', {
  # max is currenty 1000
  fake <- 1:1001
  expect_error(rcr(fake))
})

