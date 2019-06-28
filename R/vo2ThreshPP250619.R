#' An estimation of vo2max threshold and output of pedalling power
#'
#' @description
#' This function allows you to estimate in one function
#' the vo2max the Threshold and pedalling power
#' which a non regular cyclist would be physically capable of for
#' an hour at a time on a daily basis
#' It returns Vo2max (mL/kg/min) Threshold (percent)pedalling power(Watts)
#'
#' @param data dataframe optional, default is NULL
#' @param personID default = "personID" vector or character string of column name in data
#' @param age default =  "age",vector or character string of column name in data
#' @param sex default = "sex" 0 is male 1 is female
#' @param weight default = "weight", weight of bike and rider in kg
#' @param BMI default = "BMI", Body Mass Index kg/m2
#' @param PASS default = "PASScat", NASA - Physical Activity Survey
#' @param clones default  = 10
#' @param return_a_vector default = TRUE
#' @export
#' @return Vo2max Threshold percentage of Vo2max and pedal pedal power
#' @details
#' The rationale for this is described in
#' Philips I, Watling D, Timms P (2018)
#' Estimating Individual Physical Capability (IPC)
#' to make journeys by bicycle
#' International Journal of Sustainable Transportation
#' http://dx.doi.org/10.1080/15568318.2017.1368748
#'
#' @examples
#' \dontrun{
#'vo2threspp(personID = 1,age = 30, sex = 0, weight = 50,
#'           BMI = 25,PASS = 7,clones = 1,return_a_vector = F)
#' }


vo2threshpp <- function(data = NULL,personID = "personID",age = "age",
                        sex = "sex", weight = "weight",BMI = "BMI",
                        PASS = "PASScat",clones = 10,return_a_vector = TRUE){
  #set up the data input from the arguments
  if (is.null(data)) {
    #make a df from the vectors
    total <- data.frame(personID,age,sex,weight,BMI,PASS)
  } else {
    input_vars <- c(personID,age,sex,weight,BMI,PASS)
    #This subsets the input df to just keep the variables
    total <- data[input_vars]
  }

  #send the data to the Vo2max function
  total <- vo2max(data = total,PASS = "PASS",clones = clones, return_a_vector = F)

  #send the result of vo2max to LTthreshold
  total <- LTthreshold(data = total,PASS = "PASS",return_a_vector = F)


  # calculate pedal power

  #total$outputvo2 <- total$vo2max * total$weight
  #to account for non lean weight this caps outputvo2
  #total$outputvo2 [total$BMI >25 & total$outputvo2 >3000 ] <- 3000

  total$resistFW <- 0.64 * total[[4]]

  total$Power <- ((total$outputvo2 / 10) * (total$LTpercent / 100)) - total$resistFW
  total$Power [total$Power < 0] <- 0

  #cap the power output during utility riding at 260W
  #https://www.thieme-connect.com/products/ejournals/html/10.1055/s-0044-101546
  #a lab test with a group of trained cyclists found maximum training power
  #of ~260W over 60 minutes.
  total$Power [total$Power >= 260] <- 260

  total$Power <- round(total$Power,0)

  if (return_a_vector == TRUE) {
    return(as.vector(total$LTpercent))
  } else {
    return(total)
  }


}



