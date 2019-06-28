#' An estimate of a person's VO2max
#' @description
#' This is a function which estimates a persons VO2max
#' measured in milliliters of oxygen used in one minute per kilogram of body weight (mL/kg/min).
#' given the inputs of the person's age sex weight BMI and physical activity
#' It returns measures of VO2max
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
#' @return vector default or data frame of estimate of vo2max
#' @details
#' The function makes estimates of VO2max based on the regression model by Wier et al.
#' DOI:  10.1249/01.mss.0000193561.64152  given the input values.  This study
#' aims to be applicable to the population as a whole rather than just a particular
#' population segment.
#' #'
#' @examples
#' \dontrun{
#'personID <- c(1,2,3)
#'age <- c(30,40,50)
#'sex <- c(0,1,0)
#'BMI <- c(25,27,30)
#'weight <- c(50,70,90)
#'PASScat <- c(7,5,1)
#'df <- data.frame(personID,age,sex,weight,BMI,PASScat)
#'
#'test <- vo2max(data= df,personID = "personID",age = "age", sex = "sex", weight = "weight",
#'               BMI = "BMI",PASS = "PASScat",clones = 1000,return_a_vector = F)
#'test2 <- vo2max(personID = 1,age = 30, sex = 0, weight = 50,
#'                BMI = 25,PASS = 7,clones = 10,return_a_vector = F)
#'test3 <- vo2max(personID = personID,age = age, sex = sex, weight = weight,
#'                BMI = BMI,PASS = PASScat,clones = 1000,return_a_vector = F)
#'summary(test$vo2max_norm)
#'summary(test3$vo2max_norm)
#' }

#------------- function definition  ----------------------
vo2max <- function(data = NULL,personID = "personID",age = "age",
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


  #vo2max deterministic part
  # model parameters
  pconstant <-57.402
  page <- -0.372
  pmale1 <- 8.596
  pfemale0 <- 0
  pPASS <- 1.396
  pBMI <- -0.683
  pError <- 4.9

  total$vo2_no_error <- pconstant +
    (total[[2]] * page) +
    (total[[3]] *pmale1)+
    (total[[6]] *pPASS)+
    (total[[5]] * pBMI)

  #vo2max cre
  #initialize df_cre before loop
  df_cre <- total
  #make multiple clones of individuals with different Vo2max values
  for (i in 1:clones){
    dftemp <- total
    dftemp$vo2max_unif <- dftemp$vo2_no_error + (stats::runif(length(dftemp[[1]]),-1,1)*4.9)
    dftemp$vo2max_norm <- dftemp$vo2_no_error + stats::rnorm(length(dftemp[[1]]),0,4.9)
    #each iteration add a copy of each row df_no_error
    if (i != 1){
      #dftemp has more columns than df cre
      #so this line would cause an error if run when 1 = 1
      df_cre <- rbind(df_cre, dftemp)
    } else {
      df_cre <- dftemp
    }
  }
  total <- df_cre

  if (return_a_vector == TRUE) {
    #return(as.vector(total$vo2max_unif))
    total$vo2max_unif
  } else {
    return(total)
  }

}


