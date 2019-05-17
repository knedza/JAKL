# JAKL
Is there an association between depression at age 18 and computer use on weekdays and weekends at age 16?

##Identify dependent variables for Depression at at age 18
NB Age 18 years = 216 months

The closest timepoint to this in the data is at 17.5 years, where five assessments were taken in Clinic, and then 'derived by ALSPAC'. 

*dep_score	FJCI350*	Child's depression score on CIS-R.	Ordinal	Clinic	around 17.5 years	
Higher scores indicate higher levels of depressive symptomatology.  
+1 if less/no enjoyment with life during the past week, 
+1 if depressed for >3day in past week, 
+1 if depressed for >3hr in any day of past week, 
+1 if unable to be cheered up. See CIS-R Descriptive Summary for details.

*dep_thoughts	FJCI363* Child's number of depressive thoughts on CIS-R.	Ordinal	Clinic	around 17.5 years	
Higher scores indicate higher levels of depressive thoughts. 
+1 if feelings of needless guilt, 
+1 if feelings of low self-esteem, 
+1 if feelings of hopelessness, 
+1 if felt that life not worth living, 
+1 if thought seriously about suicide. See CIS-R Descriptive Summary for details.

*has_dep_diag	FJCI1001*	Child has ICD-10 diagnosis of depression	Nominal	Clinic	around 17.5 years	
Calculated from their Revised Computerised Interview Schedule (CIS-R) score. See CIS-R Descriptive Summary for more information.

*prim_diag	FJCI600*	Child's primary diagnosis in accordance with ICD-10 criteria.	Discrete	Clinic	around 17.5 years	
Primary diagnosis was determined using the CIS-R. 
0 = none, 1 = mild neurosis, 2 = mild GAD, 3 = OCD, 4 = mixed anxiety and depression, 5 = specific phobia, 6 = social phobia, 7 = agoraphobia, 8 = GAD, 9 = panic disorder, 10 = mild depression, 11 = moderate depression, 12 = severe depression

*secd_diag	FJCI601*	Child's secondary diagnosis in accordance with ICD-10.	Discrete	Clinic	around 17.5 years	
Secondary diagnosis was determined using the CIS-R. 
0 = none, 1 = mild neurosis, 2 = mild GAD, 3 = OCD, 4 = mixed anxiety and depression, 5 = specific phobia, 6 = social phobia, 7 = agoraphobia, 8 = GAD, 9 = panic disorder, 10 = mild depression, 11 = moderate depression, 12 = severe depression

##Idenitfy main IVs
NB Age 16 years = 192 months

##Primary Hypothesis in terms of variables

