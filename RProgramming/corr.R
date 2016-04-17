corr <- function(directory, threshold = 0) {
  comp <- complete(directory)
  ids <- subset(comp$id, comp$nobs>threshold)
  correlation <- numeric()
  for(i in ids) {
    specdata <- read.csv(paste0(directory, "/", formatC(i,width=3,flag="0"), ".csv"))
    correlation <- c(correlation,cor(specdata$sulfate,specdata$nitrate, "pairwise.complete.obs"))
  }
  return(correlation)
}