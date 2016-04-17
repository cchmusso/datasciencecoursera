rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcome_data <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  outcome_data[, "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"] <- as.numeric(outcome_data[, "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"])
  outcome_data[, "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"] <- as.numeric(outcome_data[, "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"])
  outcome_data[, "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"] <- as.numeric(outcome_data[, "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"])

  if (outcome == "heart attack") {
    ord <- outcome_data[order(outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, outcome_data$Hospital.Name), 
                      c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "Hospital.Name", "State")]
    
  } else if (outcome =="heart failure") {
    ord <- outcome_data[order(outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, outcome_data$Hospital.Name), 
                      c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Hospital.Name", "State")]
    
  } else if (outcome =="pneumonia") {
    ord <- outcome_data[order(outcome_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, outcome_data$Hospital.Name), 
                      c("Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia", "Hospital.Name", "State")]
    
  } else {
    stop("invalid outcome")
  }
  colnames(ord)[1] <- "outcome"
  ord <- ord[apply(ord, 1, function(x) !any(is.na(x))), ]
  if (num == "best") {
    res <- aggregate(Hospital.Name ~ State, data=ord, head, 1)
    
  } else if (num == "worst") {
    res <- aggregate(Hospital.Name ~ State, data=ord, tail, 1)
    
  } else {
    res <- aggregate(Hospital.Name ~ State, data=ord, takeNth, num)
  }
  colnames(res) <- c("state", "hospital")
  res
}


takeNth <- function(x, n) {
  x[n]
}