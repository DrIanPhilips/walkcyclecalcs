% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/LTthreshold250619.R
\name{LTthreshold}
\alias{LTthreshold}
\title{An estimation of the upper threshold}
\usage{
LTthreshold(data = NULL, personID = "personID", weight = "weight",
  BMI = "BMI", vo2max = "vo2max_unif", PASS = "PASS",
  return_a_vector = TRUE)
}
\arguments{
\item{data}{dataframe optional, default is NULL}

\item{personID}{default = "personID" vector or character string of column name in data}

\item{weight}{default = "weight", weight of bike and rider in kg}

\item{BMI}{default = "BMI", Body Mass Index kg/m2}

\item{vo2max}{default = "vo2unif", an estimate of VO2max (mL/kg/min)}

\item{PASS}{default = "PASS", NASA - Physical Activity Survey}

\item{return_a_vector}{default = TRUE}
}
\value{
Threshold percentage of Vo2max
}
\description{
This function allows you to estimate the exercise thereshold which is
lactate threshold / or threshold at 1 hour for fitter people
It returns threshold as the percentage of Vo2max
}
\details{
The rationale for this is described in
Philips I, Watling D, Timms P (2018)
Estimating Individual Physical Capability (IPC)
to make journeys by bicycle
International Journal of Sustainable Transportation
http://dx.doi.org/10.1080/15568318.2017.1368748
}
\examples{
\dontrun{
LTthreshold(personID = 1,
weight = 70,
BMI = 23,
vo2max = 55,
PASS = 9,
return_a_vector = TRUE)

personID <- c(1,2,3)
weight <- c(60,70,80)
age <- c(30,40,50)
sex <- c(0,1,0)
BMI <- c(25,27,30)
PASS <- c(7,5,1)
vo2max_unif <- c(50,40,30)
df <- data.frame(personID,weight,age,sex,BMI,PASS,vo2max_unif)
LTthreshold(data=df)
}
}
