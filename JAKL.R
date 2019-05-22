## MAPS project 
## May 2019
## JAKL team, University of Plymouth
## CC - BY 3.0

library(tidyverse)

# get data from our repository
full <- read.csv("https://raw.githubusercontent.com/knedza/JAKL/master/maps-synthetic-data-v1.1.csv")

variable.names(full)

# keep the variables we identified as useful
interesting <- full %>% select(
  'sex',
  'comp_bed_9',
  'comp_house',
  'comp_int_bed_16',
  'comp_noint_bed_16',
  'comp_week',
  'comp_wend',
  'comp_games',
  'dep_band_10',
  'dep_band_13',
  'dep_band_07',
  'dep_band_15',
  'dep_score',
  'dep_thoughts',
  'has_dep_diag',
  'prim_diag',
  'secd_diag',
  'creat_14',
  'phone_14_week',
  'phone_14_wend',
  'alon_week',
  'alon_wend',
  'draw_week',
  'draw_wend',
  'musi_week',
  'musi_wend',
  'out_sum_week',
  'out_sum_wend',
  'out_win_week',
  'out_win_wend',
  'play_week',
  'play_wend',
  'read_week',
  'read_wend',
  'talk_mob_week',
  'talk_mob_wend',
  'talk_phon_week',
  'talk_phon_wend',
  'text_wend',
  'tran_week',
  'tran_wend',
  'tv_week',
  'tv_wend',
  'work_week',
  'work_wend',
  'mat_dep',
  'text_week'
)

attach(interesting)

# what is the granularity of our main vars
table(comp_week,comp_wend)
table(comp_week)
table(comp_wend)

table(dep_score)
table(dep_thoughts)
table(has_dep_diag)
table(prim_diag)
table(secd_diag)


# at the end, save the interesting data locally so it can be uploaded
# write.csv(interesting, 'jakl.csv')
# 

# make a variable combining primary and secondary diagnosis if any of 4, 10, 11 or 12 mentioned on either
# 

interesting$anydepdiag <- 0

interesting$anydepdiag[interesting$prim_diag==4 |
                         interesting$prim_diag==10 |
                         interesting$prim_diag==11 |
                         interesting$prim_diag==12 ]  <- 1

interesting$anydepdiag[interesting$secd_diag==4 |
                         interesting$secd_diag==10 |
                         interesting$secd_diag==11 |
                         interesting$secd_diag==12 ]  <- 1



# This finds 419 people, only 389 of whom have 'Yes' for has_dep_diag

table(interesting$has_dep_diag, interesting$anydepdiag)




# Logistic regression to predict anydepdiag from computer use on weekdays and at weekends
# follows examples at https://stats.idre.ucla.edu/r/dae/logit-regression/
# uses package aod

library(aod)

logit.model <- glm(data=interesting, anydepdiag ~ comp_week + comp_wend, family="binomial")
summary(logit.model)
confint(logit.model)  # confidence intervals on co-efficients estimates based on the profiled log-likelihood function

# test overall effect of weekday use
wald.test(b = coef(logit.model), Sigma = vcov(logit.model), Terms = 2:4)
# test overall effect of weekend use
wald.test(b = coef(logit.model), Sigma = vcov(logit.model), Terms = 5:7)
# contrast low use with high use
lohi <- cbind(0, -2, 1, 1,  -2, 1, 1)
wald.test(b = coef(logit.model), Sigma = vcov(logit.model), L = lohi)
# odds ratios and 95%CI
exp(cbind(OR = coef(logit.model), confint(logit.model)))
# predict probabilities
# build dataframe of every combined level of the two use factors
newdata <- data.frame(expand.grid(comp_week=factor(levels(interesting$comp_week)), 
                                  comp_wend=factor(levels(interesting$comp_wend)) ))
# add in the Prediction
newdata$pred <- predict(logit.model, newdata = newdata, type="response")
# could add plots here 
# 
# measures of model fit
dev.diff <- with(logit.model, null.deviance - deviance) # difference in deviances
df.diff <- with(logit.model, df.null - df.residual) # difference in df
model.p <- with(logit.model, pchisq(dev.diff, df.diff, lower.tail=FALSE))
paste("Difference",dev.diff,", df=",df.diff,"p=",model.p)


