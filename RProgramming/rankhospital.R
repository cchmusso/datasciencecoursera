rankhospital("MD", "heart failure", 5)

rankhospital <- function(state, outcome, num="best") {
  ## Read outcome data
  outcome_data <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  outcome_data[, "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"] <- as.numeric(outcome_data[, "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"])
  outcome_data[, "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"] <- as.numeric(outcome_data[, "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"])
  outcome_data[, "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"] <- as.numeric(outcome_data[, "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"])
  
  state_data <- subset(outcome_data, outcome_data$State == state)
  if (nrow(state_data) == 0) {
    stop("invalid state")
  }
  if (outcome == "heart attack") {
    ord <- state_data[order(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, state_data$Hospital.Name), 
                      c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "Hospital.Name", "State")]
    
  } else if (outcome =="heart failure") {
    ord <- state_data[order(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, state_data$Hospital.Name), 
                      c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Hospital.Name", "State")]
    
  } else if (outcome =="pneumonia") {
    ord <- state_data[order(state_data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, state_data$Hospital.Name), 
                      c("Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia", "Hospital.Name", "State")]
    
  } else {
    stop("invalid outcome")
  }
  if (num == "best") {
    ord$Hospital.Name[1]
    
  } else if (num == "worst") {
    tail(ord$Hospital.Name[!is.na(ord[, 1])], 1)
    
  } else {
    ord$Hospital.Name[num]
  }
}