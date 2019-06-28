#Test threshold function

context("test threshold function")

test_that("test vo2max",{
  set.seed(99)
  expect_equal(
               round(LTthreshold(personID = 1,
                weight = 70,
                BMI = 23,
                vo2max = 55,
                PASS = 9,
                return_a_vector = TRUE),1)
               ,61.7)


})


