TEAM_NAME="jakl"
VERSION="R version 3.6.0 (2019-04-26)"
# revised by JM 2019.06.25

load_data <- function(path){
  # Loads the data using base R.
  # 
  data <- read.csv(path, stringsAsFactors = T)
  data
}


computer_use_001 <- function(data){
  # Computer use is defined using 'comp_week' and 'comp_wend'
  
  # IMPORTS
  
  
  # DEFINE COMPUTER USE
  # Assign average numeric values for each of the categories
  # rename comp_week as comp_use_1 and comp_wend as comp_use_2 
  # reorder the levels of comp_week and comp_wend
  
  data$comp_use_1 <- factor(data$comp_week,levels(data$comp_week)[c(4,3,1,2)])
  data$comp_use_2 <- factor(data$comp_wend,levels(data$comp_wend)[c(4,3,1,2)])
  
  # keep these names for plotting later
  #iv.levels <- levels(data$comp_week)
  
  
  data
}

depression_001 <- function(data){
  # This function defines depression using 'prim_diag' and
  # 'secd_diag', values 10-12 and also 4 'mixed anxiety and depression'
  
  #IMPORTS:
  
  #PARAMETERS:
  
  #DEFINE DEPRESSION:
  data$depression <- 0
  
  data$depression[data$prim_diag==4 |
                           data$prim_diag==10 |
                           data$prim_diag==11 |
                           data$prim_diag==12 ]  <- 1
  
  data$depression[data$secd_diag==4 |
                           data$secd_diag==10 |
                           data$secd_diag==11 |
                           data$secd_diag==12 ]  <- 1
 
  data 
}

transformation_001 <- function(data){
  # This selects some variables to use in final model
  # IMPORTS
  library(tidyverse) # added back in by JM 2019.06.25
  
  # PARAMETERS
  VARIABLES_TO_USE <- c('depression', 'comp_use_1', 'comp_use_2')
  
  # select data
  data <- select(data, VARIABLES_TO_USE)
  data
}


specify_model <- function(data){
 
  # Logistic regression to predict depression from computer use on weekdays and at weekends
  # follows examples at https://stats.idre.ucla.edu/r/dae/logit-regression/
  # uses package aod

  # IMPORTS
  library(aod)
  library(tidyverse)
  
  
  # logistic regression model
  
  model <- glm(data=data, depression ~ comp_use_1 + comp_use_2, family="binomial")
  summary(model)
  confint(model)  # confidence intervals on co-efficients estimates based on the profiled log-likelihood function
  

  
  # log odds ratio s.e. and lower/upper bounds for CI
  lor <- model$coefficients[2:7]
  lse <- summary(model)$coefficients[2:7,2]
  llb <- lor - 2*lse
  lub <-  lor + 2*lse
  
  # exponentiate
  or <- exp(lor)
  ci <- exp(c(llb, lub))
  
  # the results 
  # Note: DIC not necessary (not Bayes/Hierarchical model)
  #       data must be returned as part of a list because R can't return multiple objects
  #       list elements below separated by JM 2019.06.25
  results <- list('aic' = model$aic, 
                  'or_1' = exp(model$coefficients[2]), # odds ratio for VAR: comp_use_1 LEVEL: less than 1 hour
                  'or_2' = exp(model$coefficients[3]), # odds ratio for VAR: comp_use_1 LEVEL: 1 - 2 hours
                  'or_3' = exp(model$coefficients[4]), # odds ratio for VAR: comp_use_1 LEVEL: 3 or more hours
                  'or_4' = exp(model$coefficients[5]), # odds ratio for VAR: comp_use_2 LEVEL: less than 1 hour
                  'or_5' = exp(model$coefficients[6]), # odds ratio for VAR: comp_use_2 LEVEL: 1 - 2 hours
                  'or_6' = exp(model$coefficients[7]), # odds ratio for VAR: comp_use_2 LEVEL: 3 or more hours
                  'p_1' = summary(model)$coefficients[2,4], # p value for VAR: comp_use_1 LEVEL: less than 1 hour
                  'p_2' = summary(model)$coefficients[3,4], # p value for VAR: comp_use_1 LEVEL: 1 - 2 hours
                  'p_3' = summary(model)$coefficients[4,4], # p value for VAR: comp_use_1 LEVEL: 3 or more hours
                  'p_4' = summary(model)$coefficients[5,4], # p value for VAR: comp_use_2 LEVEL: less than 1 hour
                  'p_5' = summary(model)$coefficients[6,4], # p value for VAR: comp_use_2 LEVEL: 1 - 2 hours
                  'p_6' = summary(model)$coefficients[7,4], # p value for VAR: comp_use_2 LEVEL: 3 or more hours
                  'ci_1' = c(ci[1],ci[7]),  # CI pair (low, high)  for VAR: comp_use_1 LEVEL: less than 1 hour
                  'ci_2' = c(ci[2],ci[8]),  # CI pair (low, high)  for VAR: comp_use_1 LEVEL: 1 - 2 hours
                  'ci_3' = c(ci[3],ci[9]),  # CI pair (low, high)  for VAR: comp_use_1 LEVEL: 3 or more hours
                  'ci_4' = c(ci[4],ci[10]), # CI pair (low, high)  for VAR: comp_use_2 LEVEL: less than 1 hour
                  'ci_5' = c(ci[5],ci[11]), # CI pair (low, high)  for VAR: comp_use_2 LEVEL: 1 - 2 hours
                  'ci_6' = c(ci[6],ci[12]), # CI pair (low, high)  for VAR: comp_use_2 LEVEL: 3 or more hours
                  'mod' = model, 
                  'data' = data)
  results
}

# output function which displayed selected elements of results removed by JM 2019.06.25






#### lines to run functions
data <- load_data(path = 'https://raw.githubusercontent.com/knedza/JAKL/master/maps-synthetic-data-v1.1.csv')
data <- computer_use_001(data)
data <- depression_001(data)
data <- transformation_001(data)
results <- specify_model(data)

 