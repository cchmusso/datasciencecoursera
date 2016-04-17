pollutantmean <- function(directory, pollutant, id=1:332) {
  data <- c()
  for (i in id) {
    specdata <- read.csv(paste0(directory, "/", formatC(i,width=3,flag="0"), ".csv"))
    data <- c(data, specdata[, pollutant])
  }
  mean(data, na.rm=TRUE)
}
