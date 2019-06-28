#' An estimation of pedalling power
#' @description
#' This function allows you to estimate the pedalling power
#' which a non regular cyclist would be physically capable of for
#' an hour at a time on a daily basis
#' It returns pedalling power in Watts
#'
#' @param data dataframe optional, default is NULL
#' @param personID default = "personID" vector or character string of column name in data
#' @param weight default = "weight", weight of bike and rider in kg
#' @param outputvo2 default = "outputvo2", estimate of volume oxygen uptake per min (mL/min)
#' @param LTpercent default = "LTpercent", Threshold percentage of Vo2max
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
#'
#' @examples
#' \dontrun{
#'pedal_power(personID = 1,
#'            weight = 70,
#'            outputvo2 = 3850,
#'            LTpercent = 72.5,
#'            return_a_vector = TRUE)
#'}


pedal_power <- function(data = NULL, personID = "personID",
                        weight = "weight",
                        outputvo2 = "outputvo2",
                        LTpercent = "LTpercent",
                        return_a_vector = TRUE){

  #set up the data input from the arguments
  if (is.null(data)) {
    #make a df from the vectors
    total <- data.frame(personID,outputvo2,LTpercent,weight)
  } else {
    input_vars <- c(personID,outputvo2,LTpercent,weight)
    #This subsets the input df to just keep the variables
    total <- data[input_vars]
  }

  # calculate pedal power
  #resistFW is work of lifting legs and internal organs
  total$resistFW <- 0.64 * total$weight
  total$Power <- ((total$outputvo2 / 10) * (total$LTpercent / 100)) - total$resistFW
  total$Power [total$Power < 0] <- 0

  #cap the power output during utility riding at 260W
  #https://www.thieme-connect.com/products/ejournals/html/10.1055/s-0044-101546
  #a lab test with a group of trained cyclists found maximum training power
  #of ~260W over 60 minutes.
  total$Power [total$Power >= 260] <- 260

  total$Power <- round(total$Power,0)

  if (return_a_vector == TRUE) {
    return(as.vector(total$Power))
  } else {
    return(total)
  }
}



