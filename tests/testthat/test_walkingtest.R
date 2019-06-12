#Test basic walking functions

context("test basic walking functions")

test_that("test Naismithwalkspeed",{
  expect_equal(round(naismithwalkspeed(40,4),6),4.285714)


})
