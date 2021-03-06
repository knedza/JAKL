# JAKL
Is there an association between depression at age 18 and computer use on weekdays and weekends at age 16?

## Identify dependent variables for Depression at at age 18
NB Age 18 years = 216 months

The closest timepoint to this in the data is at 17.5 years, where five assessments were taken in Clinic, and then 'derived by ALSPAC'. 

*dep_score	FJCI350*	Child's depression score on CIS-R.	Ordinal	Clinic	around 17.5 years	
- Higher scores indicate higher levels of depressive symptomatology.  
- +1 if less/no enjoyment with life during the past week, 
- +1 if depressed for >3day in past week,
- +1 if depressed for >3hr in any day of past week, 
- +1 if unable to be cheered up. See CIS-R Descriptive Summary for details.


| 0  | 1 | 2 | 3 | 4 |
| ------------- | ------------- | --- | --- | --- |
| 3463  | 488  | 299 | 163 | 100 |

*dep_thoughts	FJCI363* Child's number of depressive thoughts on CIS-R.	Ordinal	Clinic	around 17.5 years	
- Higher scores indicate higher levels of depressive thoughts. 
-    +1 if feelings of needless guilt, 
-    +1 if feelings of low self-esteem, 
-    +1 if feelings of hopelessness, 
-    +1 if felt that life not worth living, 
-    +1 if thought seriously about suicide. See CIS-R Descriptive Summary for details.
    
| 0  | 1 | 2 | 3 | 4 | 5 |
| ------------- | ------------- | --- | --- | --- | --- |
|   86 | 897 | 282 | 225 | 223  | 92  |

*has_dep_diag	FJCI1001*	Child has ICD-10 diagnosis of depression	Nominal	Clinic	around 17.5 years	
- Calculated from their Revised Computerised Interview Schedule (CIS-R) score. See CIS-R Descriptive Summary for more information.

| No ICD-10 diagnosis of depression | Yes ICD-10 diagnosis of depression |
| ------------- | ------------- |
| 4124    |  389  |


*prim_diag	FJCI600*	Child's primary diagnosis in accordance with ICD-10 criteria.	Discrete	Clinic	around 17.5 years	
Primary diagnosis was determined using the CIS-R. 

| 0 = none | 1 = mild neurosis | 2 = mild GAD | 3 = OCD |  4 = mixed anxiety and depression |  5 = specific phobia | 6 = social phobia | 7 = agoraphobia | 8 = GAD | 9 = panic disorder | 10 = mild depression | 11 = moderate depression | 12 = severe depression |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 3573 | 240 |  99 |  0 | 11 | 101  | 66  |  6  | 22  |  6 | 134 | 181  | 74 |

*secd_diag	FJCI601*	Child's secondary diagnosis in accordance with ICD-10.	Discrete	Clinic	around 17.5 years	
Secondary diagnosis was determined using the CIS-R. 


| 0 = none | 1 = mild neurosis | 2 = mild GAD | 3 = OCD |  4 = mixed anxiety and depression |  5 = specific phobia | 6 = social phobia | 7 = agoraphobia | 8 = GAD | 9 = panic disorder | 10 = mild depression | 11 = moderate depression | 12 = severe depression |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 3980 | 246  | 43  | 0 | 62  | 44  | 19  |  3 |  94  | 22 | 0 | 0 | 0 |

We would be looking at values of 4, 10, 11 or 12; there is an order 10-11-12 but 4 is separate

## transform collected data into DV
We combine primary and secondary - if 4, 10, 11, 12 in either or both then YES else NO. This creates our dichotomous dependent variable *anydepdiag*

``` {r}
data$anydepdiag <- 0
  
  data$anydepdiag[data$prim_diag==4 |
                           data$prim_diag==10 |
                           data$prim_diag==11 |
                           data$prim_diag==12 ]  <- 1
  
  data$anydepdiag[data$secd_diag==4 |
                           data$secd_diag==10 |
                           data$secd_diag==11 |
                           data$secd_diag==12 ]  <- 1
 ```


## Identify main IVs
NB Age 16 years = 192 months
Closest measurement point in data is at 198 months

*comp_week	ccs1010*	Average time child spent per day using a computer on a typical weekday	Ordinal	Child	
How much time on average do you spend each day ... using a computer ... on a typical weekday?	
Not at all, < 1 hour, 1-2 hours, 3 or more hours

| Not at all    | Less than 1 hour   |       1-2 hours | 3 or more hours |
| --- | --- | --- | --- |
|          96      |           1069     |      2375    |       1471      |


*comp_wend	ccs1030*	Average time child spent per day using a computer on a typical weekend day	Ordinal	Child
How much time on average do you spend each day ... using a computer ... on a typical weekend day?
Not at all, < 1 hour, 1-2 hours, 3 or more hours

| Not at all    | Less than 1 hour   |       1-2 hours | 3 or more hours |
| --- | --- | --- | --- |
|           158   |             927   |          1950 |            1804  |            

## Analysis
We looking at weekdays and weekends independently.

Conduct a Logistic regression to predict *anydepdiag* from *comp_week* and *comp_wend* 

``` {r}
 library(aod)
 
 model <- glm(data=data, anydepdiag ~ comp_week + comp_wend, family="binomial")
```

This shows that computer use of more than an hour a day during the week reduced the risk of depression. Computer use at weekends of more than an hour a day increases the risk, insignificantly.

There may be an artefact with depressed people over or underestimating time spent angaging in activities.

We checked this by repeating the analysis with some additional IVs collected alongside the self reported computer use:
_How much time the child spends alone, how much time they spend outside, time they spend socialising with other young people, and time they spend on their mobile (talk/text)_

None of these additional variables had a significant effect uopn the likelihood of a diagnosis of depression at age 18.



