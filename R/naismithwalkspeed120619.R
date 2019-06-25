#' The speed a person walks based on Naismith's rule
#' @description
#' This is a function which estimates how far
#' a person could walk in one hour (in km/hr)
#' given the inputs of the person's VO2max and the slope of the hill
#' It returns the speed
#'
#'
#' @param vo2max vector, the Vo2max of each individual (ml/kg/min-1)
#' @param slope vector, slope of the route as a percentage
#' @export
#' @return walking speed km/hr
#' @details
#' long form explanation of the function
#' @examples
#' \dontrun{
#' naismithwalkspeed(40,4)
#' naismithwalkspeed(c(40,30),c(4,2))
#' }

naismithwalkspeed <- function(vo2max,slope){

  flatwalkspeed <- (((vo2max*0.5)-5)/2.5)
  if (flatwalkspeed > 6) {flatwalkspeed <- 6}

  #get walk speed in m/s
  flatwalkspeed <- flatwalkspeed / 3.6

  sec_per_flat_m <- 1/ flatwalkspeed
  sec_per_flat_m

  climb_per_flat_m <- slope/100
  climb_per_flat_m

  #naismith says add 1 minute per 10 metres ascended
  #= 6 seconds per metre ascended
    climb_time_per_flat_m <- climb_per_flat_m *6
  climb_time_per_flat_m

  tot_time_m <- sec_per_flat_m + climb_time_per_flat_m
  tot_time_m

  naismith_speed_ms <- 1/tot_time_m

  walk_speed_kmh <- naismith_speed_ms *3.6

  #set Sensible limits
  walk_speed_kmh[walk_speed_kmh > 6 ] <- 6
  walk_speed_kmh[walk_speed_kmh < 0 ] <- 0


  return(walk_speed_kmh)

}



#' A very simple histogram plot of walk speed
#' @description
#' This is a function which plots a histogram of
#' the results of naismithwalkspeed using ggplot
#'
#' @param walk_speed_kmh vector, walking speed km/hr
#' @export
#' @return a ggplot2 histogram
#' @details
#' long form explanation of the function
#' @examples
#' \dontrun{
#' nplot(c(2,2,4,6,6))
#' }


nplot <- function (walk_speed_kmh){
  #add a ggplot task so that we have to deal with dependencies
  p <- ggplot2::ggplot() +
    ggplot2::geom_histogram(ggplot2::aes(walk_speed_kmh))
  print(p)
}
