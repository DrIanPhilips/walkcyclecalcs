#Test VO2max function

context("test vo2max function")

test_that("test vo2max",{
  expect_equal(round(vo2max(personID = 1,age = 30, sex = 0, weight = 50,
                            BMI = 25,PASS = 7,clones = 1,return_a_vector = F)[[1,7]],3)
               ,38.939)


})


