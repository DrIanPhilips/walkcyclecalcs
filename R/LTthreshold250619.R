#' An estimation of the upper threshold
#'
#' @description
#' This function allows you to estimate the exercise thereshold which is
#' lactate threshold / or threshold at 1 hour for fitter people
#' It returns threshold as the percentage of Vo2max
#'
#' @param data dataframe optional, default is NULL
#' @param personID default = "personID" vector or character string of column name in data
#' @param weight default = "weight", weight of bike and rider in kg
#' @param BMI default = "BMI", Body Mass Index kg/m2
#' @param vo2max default = "vo2unif", an estimate of VO2max (mL/kg/min)
#' @param PASS default = "PASS", NASA - Physical Activity Survey
#' @param return_a_vector default = TRUE
#' @export
#' @return Threshold percentage of Vo2max
#' @details
#' The rationale for this is described in
#' Philips I, Watling D, Timms P (2018)
#' Estimating Individual Physical Capability (IPC)
#' to make journeys by bicycle
#' International Journal of Sustainable Transportation
#' http://dx.doi.org/10.1080/15568318.2017.1368748
#' @examples
#' \dontrun{
#'LTthreshold(personID = 1,
#'weight = 70,
#'BMI = 23,
#'vo2max = 55,
#'PASS = 9,
#'return_a_vector = TRUE)
#'
#'personID <- c(1,2,3)
#'weight <- c(60,70,80)
#'age <- c(30,40,50)
#'sex <- c(0,1,0)
#'BMI <- c(25,27,30)
#'PASS <- c(7,5,1)
#'vo2max_unif <- c(50,40,30)
#'df <- data.frame(personID,weight,age,sex,BMI,PASS,vo2max_unif)
#'LTthreshold(data=df)
#' }

LTthreshold <- function(data = NULL,
                        personID = "personID",
                        weight = "weight",
                        BMI = "BMI",
                        vo2max ="vo2max_unif",
                        PASS = "PASS",
                        return_a_vector = TRUE){

  #set up the data input from the arguments
  if (is.null(data)) {
    #make a df from the vectors
    total <- data.frame(personID,weight,BMI,vo2max,PASS)
  } else {
    input_vars <- c(personID,weight,BMI,vo2max,PASS)
    #This subsets the input df to just keep the variables
    total <- data[input_vars]
  }

  total$outputvo2 <- total$vo2max * total$weight
  #to account for non lean weight this caps outputvo2
  total$outputvo2 [total$BMI >25 & total$outputvo2 >3000 ] <- 3000
  #estimate LT (lactate threshold / ) deterministic component

  total$LTpercent [total$BMI <= 25] <- 55
  total$LTpercent [total$BMI > 25 & total$BMI <30 ] <- 54
  total$LTpercent [total$BMI >= 30] <- 48
  #estimate LT probabalistic exercise component

  total$LTpercent [total$PASS == 6] <- round(total$LTpercent + (stats::runif(1) * 10),1)
  total$LTpercent [total$PASS >= 7] <- round(60 + (stats::runif(1) * 15),1)

  if (return_a_vector == TRUE) {
    return(as.vector(total$LTpercent))
  } else {
    return(total)
  }

}
