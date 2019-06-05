TEAM_NAME="jakl"
VERSION="R version 3.6.0 (2019-04-26)"

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
  # reorder the levels of comp_week and comp_wend
  
  data$comp_week <- factor(data$comp_week,levels(data$comp_week)[c(4,3,1,2)])
  data$comp_wend <- factor(data$comp_wend,levels(data$comp_wend)[c(4,3,1,2)])
  
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
  data$anydepdiag <- 0
  
  data$anydepdiag[data$prim_diag==4 |
                           data$prim_diag==10 |
                           data$prim_diag==11 |
                           data$prim_diag==12 ]  <- 1
  
  data$anydepdiag[data$secd_diag==4 |
                           data$secd_diag==10 |
                           data$secd_diag==11 |
                           data$secd_diag==12 ]  <- 1
 
  data 
}

transformation_001 <- function(data){
  # This selects some variables to use in final model
  # IMPORTS
 
  # PARAMETERS
  VARIABLES_TO_USE <- c('anydepdiag', 'comp_week', 'comp_wend')
  
  # select data
  data <- select(data, VARIABLES_TO_USE)
  data
}


specify_model <- function(data){
 
  # Logistic regression to predict anydepdiag from computer use on weekdays and at weekends
  # follows examples at https://stats.idre.ucla.edu/r/dae/logit-regression/
  # uses package aod

  # IMPORTS
  library(aod)
  library(tidyverse)
  
  
  # logistic regression model
  
  model <- glm(data=data, anydepdiag ~ comp_week + comp_wend, family="binomial")
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
  results <- list('aic' = model$aic, 
                  'or_1' = exp(model$coefficients[2:7]), 
                  'p_1' = summary(model)$coefficients[2:7,4], 
                  'ci_1' = ci, 
                  'mod' = model, 
                  'data' = data)
  results
}

output <- function(results){
 # make some visible output so we can see what the model has done
   
  # IMPORTS
  library(tidyverse)
  library(pander)
  
  # send reportables to console
  message(paste("AIC=",results$aic))
  message(results$or_1  %>% pandoc.table(caption="Odds Ratios"))
  message(results$p_1  %>% pandoc.table(caption="Probabilities"))
  message(results$ci_1 %>% pandoc.table(caption="Confidence Intervals"))
  
  
}






#### lines to run functions
data <- load_data(path = 'https://raw.githubusercontent.com/knedza/JAKL/master/maps-synthetic-data-v1.1.csv')
data <- computer_use_001(data)
data <- depression_001(data)
data <- transformation_001(data)
results <- specify_model(data)
output(results)


 