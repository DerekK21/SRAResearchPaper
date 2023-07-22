/*APPENDING DATA SETS
REPLACE "C:\Users\derek\OneDrive\Desktop\SRAResearch\Data\" WITH YOUR DIRECTORY/WHERE DOWNLOADED
*/

use "C:\Users\derek\OneDrive\Desktop\SRAResearch\Data\2019"
append using "C:\Users\derek\OneDrive\Desktop\SRAResearch\Data\2018"
append using "C:\Users\derek\OneDrive\Desktop\SRAResearch\Data\2017"

*IMPORT PACKGAGE FOR REGRESSION TABLE COMMANDS
. ssc install estout, replace

*DEFINING VARS - AGE: ageOver - BINARY VAR FOR AGEOVER 85, ageBelow - INT
gen age = age_p if age_p != .
replace age = agep_a if agep_a != .
drop if age >= 85

*SEX - BINARY VAR
gen sexA = 0 if sex == 1
replace sexA = 1 if sex == 2
replace sexA = 0 if sex_a == 1
replace sexA = 1 if sex_a == 2
drop sex
gen sex = sexA

*RACE - CATEGORICAL VAR
gen race = 0 if racerpi2 == 1 | raceallp_a == 1
replace race = 1 if racerpi2 == 2 | raceallp_a == 2
replace race = 2 if racerpi2 == 4 | raceallp_a == 3
replace race = 3 if racerpi2 == 3 | raceallp_a == 4
replace race = 4 if racerpi2 == 6 | raceallp_a == 5 | raceallp_a == 6

*BMI - CAT. VAR
replace bmicat_a = 1 if bmi < 18.5
replace bmicat_a = 2 if bmi < 24.9 & bmi >= 18.5
replace bmicat_a = 3 if bmi < 29.9 & bmi >= 25.0
replace bmicat_a = 4 if bmi >= 30.0
rename bmicat_a bmicat

*HOW WORRIED ABOUT MEDICAL BILLS - CAT. VAR
gen medBillWorry = 0 if payworry_a == 3 | aworpay == 3
replace medBillWorry = 1 if payworry_a == 2 | aworpay == 2
replace medBillWorry = 2 if payworry_a == 1 | aworpay == 1

*INCOME - CAT. VAR
gen incomeGrp = 0 if incgrp_a == 1 | incgrp4 == 1
replace incomeGrp = 1 if incgrp_a == 2 | incgrp4 == 2
replace incomeGrp = 2 if incgrp_a == 3 | incgrp4 == 3
replace incomeGrp = 3 if incgrp_a == 4 | incgrp4 == 4
replace incomeGrp = 4 if incgrp_a == 5 | incgrp4 == 5

*HYPERTENSION - BINARY VAR
gen hyprtn = 0 if hypyr1 == 2 | hyp12m_a == 2 | hypev == 2 | hypev_a == 2
replace hyprtn = 1 if hypyr1 == 1 | hyp12m_a == 1

*HEART DISEASE - BINARY VARS
gen heartDis = 0 if chdev_a == 2 | hrtev == 2
replace heartDis = 1 if chdev_a == 1 | hrtev == 1
 
*DIABETES: hasDiabetes - BINARY, type1 - BINARY, type2 - BINARY
gen hasDiabetes = 0 if (predib_a == 2 & dibev_a == 2) | dibev1 == 2
replace hasDiabetes = 1 if dibev_a == 1 | predib_a == 1 | dibev1 == 1 | dibev1 == 3
gen type1 = 0 if hasDiabetes == 0 | predib_a == 1 | dibev1 == 3 | (dibtype_a != 1 & dibtype_a != .) | (dibtype != 1 & dibtype != .)
replace type1 = 1 if (hasDiabetes == 1 & dibtype == 1) | (hasDiabetes == 1 & dibtype_a == 1)
gen type2 = 0 if hasDiabetes == 0 | (dibtype_a != 2 & dibtype_a != .) | (dibtype != 2 & dibtype != .)
replace type2 = 1 if predib_a == 1 | dibev1 == 3 | (hasDiabetes == 1 & dibtype == 2) | (hasDiabetes == 1 & dibtype_a == 2)
 
*HEARING WITHOUT HEARING AID - CAT. VAR
gen hearNoAid = 0 if (hraidnow == 2 & ahearst1 == 1) | (hearingdf_a == 1 & hearaid_a == 2)
replace hearNoAid = 0 if hraidnow == 2 & ahearst1 == 2
replace hearNoAid = 1 if (hraidnow == 2 & ahearst1 == 3) | (hraidnow == 2 & ahearst1 == 4) | (hearingdf_a == 2 & hearaid_a == 2)
replace hearNoAid = 2 if (hraidnow == 2 & ahearst1 == 5) | (hraidnow == 2 & ahearst1 == 6) | (hearingdf_a == 3 & hearaid_a == 2) | (hearingdf_a == 4 & hearaid_a == 2)

*IF USING AN AID - BINARY VAR
gen useAid = 1 if hraidnow == 1 | hearaid_a == 1
replace useAid = 0 if hraidnow == 2 | hearaid_a == 2

*HEARING WITH AN AID - CAT. VARS
gen hearWithAid = 0 if useAid == 1 & hear_ss2 == 1
replace hearWithAid = 0 if hearingdf_a == 1 & useAid == 1
replace hearWithAid = 1 if (hear_ss2 == 2 & useAid == 1) | (hearingdf_a == 2 & useAid == 1)
replace hearWithAid = 2 if (hear_ss2 == 3 & useAid == 1) | (hear_ss2 == 4 & useAid == 1) | (hearingdf_a == 3 &useAid == 1) | (hearingdf_a == 4 & useAid == 1)


/*DEFINING LABELS - AGE
label define ageBelow 85 "85 and Over"
label values ageBelow ageBelow
label variable ageBelow "Age" */

*SEX
label define sex 0 "Male" 1 "Female"
label values sex sex
label variable sex "Sex"

*RACE
label define race 0 "White" 1 "Black/African American" 2 "Asian" 3 "Native American" 4 "Multiple Races"
label values race race
label variable race "Race"

*HOW WORRIED ABOUT MEDICAL BILLS
label define medBillWorry 0 "No Worry" 1 "Some Worry" 2 "A lot of Worry"
label values medBillWorry medBillWorry
label variable medBillWorry "Worried About Paying Bills"

*INCOME
label define incomeGrp 0 "$0-$34999" 1 "$35000-$49999" 2 "$50000-74999" 3 "$75000-$99999" 4 "$100000 and over"
label values incomeGrp incomeGrp
label variable incomeGrp "Income Level"

*HYPERTENSION
label define hyprtn 0 "No Hypertension" 1 "Has Hypertension"
label values hyprtn hyprtn
label variable hyprtn "Hypertension"

*HEART DISEASE
label define heartDis 0 "No Heart Disease" 1 "Has Heart Disease"
label values heartDis heartDis
label variable heartDis "Heart disease"

*HEARING WITHOUT HEARING AID
label define hearNoAid 0 "No Difficulty Hearing" 1 "Some Difficulty Hearing" 2 "Severe Difficulty Hearing"
label values hearNoAid hearNoAid
label variable hearNoAid "Hear Without Using Aid"

*IF USE AN AID
label define useAid 0 "No Aid" 1 "Use Aid"
label values useAid useAid
label variable useAid "Using Aid"

*HEARING WITH AN AID
label define hearWithAid 0 "No Difficulty Hearing" 1 "Some Difficulty Hearing" 2 "Severe Difficulty Hearing"
label values hearWithAid hearWithAid
label variable hearWithAid "Hear Using Aid"

*DROP UNNECESSARY
keep age sex race bmicat medBillWorry incomeGrp hyprtn heartDis hasDiabetes type1 type2 hearNoAid useAid hearWithAid

drop if age == .
drop if bmicat == .
drop if sex == .
drop if race == .
drop if medBillWorry == .
drop if incomeGrp == .
drop if hyprtn == .
drop if heartDis == .
drop if hasDiabetes == .
drop if useAid == .
drop if hearNoAid == . & useAid == 0
drop if hearWithAid == . & useAid == 1


*GRAPHS AND TABLES (GRAPHS WILL BE FROM EXCEL)
graph bar hyprtn type2 heartDis, over(hearNoAid)
graph bar hyprtn type2 heartDis, over(hearWithAid)
*DATA FOR GRAPHS
table heartDis hearNoAid if useAid	== 0, statistic (percent, across(heartDis))
table type2 hearNoAid if useAid	== 0, statistic (percent, across(type2))
table hyprtn hearNoAid if useAid == 0, statistic (percent, across(hyprtn))

*REGRESSIONS
eststo clear
eststo: quietly regress hypr i.hearNoAid age i.race sex i.incomeGrp, robust
eststo: quietly regress hasDiabetes i.hearNoAid age i.race sex i.incomeGrp, robust
eststo: quietly regress heartDis i.hearNoAid age i.race sex i.incomeGrp, robust
esttab, se label title("Regression 1: Health Outcomes by Hearing Level Without Aid") nonumbers mtitles("Hypertension" "T2 Diabetes" "CV Disease") addnote("T2 Diabetes refers to Type 2 Diabetes. CV Disease refers to cardio-vascular/heart disease. Coefficents for Some and Severe Difficulty Hearing should be read as percent more likely to have each category compared to no difficulty, ie, .104 --> 10.4%"), 
eststo clear
eststo: quietly regress hypr i.hearWithAid age i.race sex i.incomeGrp, robust
eststo: quietly regress hasDiabetes i.hearWithAid age i.race sex i.incomeGrp, robust
eststo: quietly regress heartDis i.hearWithAid age i.race sex i.incomeGrp, robust
esttab, se label title("Regression 2: Health Outcomes by Hearing Level With an Aid") nonumbers mtitles("Hypertension" "T2 Diabetes" "CV Disease") addnote("T2 Diabetes refers to Type 2 Diabetes. CV Disease refers to cardio-vascular disease. Coefficents for Some and Severe Difficulty Hearing should be read as percent more likely to have each category compared to no difficulty, ie, .104 --> 10.4%")

*SUMMARY STATS
summ /*Treatment*/ i.hearNoAid useAid i.hearWithAid /*Control*/ sex age i.race i.medBillWorry i.incomeGrp i.bmicat /*Result*/ hyprtn heartDis hasDiabetes type1 type2 if useAid == 0

/*OTHER TABLES:
RELATION BETWEEN WORRY OF MEDICAL BILLS AND HEARING
*/
table medBillWorry hearNoAid if useAid == 0, statistic (percent, across(medBillWorry))
table medBillWorry hearWithAid if useAid == 1, statistic (percent, across(medBillWorry))


*CHANGE FOR YOUR DIRECTORY 
save "C:\Users\derek\OneDrive\Desktop\SRAResearch\Data\AdultCleanR.dta"
