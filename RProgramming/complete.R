complete <- function(directory, id=1:332) {
  res <- data.frame()
  for (i in id) {
    specdata <- read.csv(paste0(directory, "/", formatC(i,width=3,flag="0"), ".csv"))
    res <- rbind(res, c(i,sum(complete.cases(specdata))))
  }
  colnames(res) <- c("id", "nobs")
  res
}