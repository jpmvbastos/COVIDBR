use "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/COVIDBR_Final.dta", clear

* Change in health inputs

gen delta_doctors = doctors2020 / doctors2019
gen delta_icu = icu2020 / icu2019
gen delta_hosp = hospitalbeds2020 / hospitalbeds2019

gen delta_pub = pub_2020 / pub_2019 
gen delta_priv = priv_2020 / pub_2019
gen delta_phi = phi_2020 / phi_2019

gen delta_pub_sus = pub_sus_2020 / pub_sus_2019 
gen delta_priv_sus = priv_sus_2020 / pub_sus_2019
gen delta_phi_sus = phi_sus_2020 / phi_sus_2019

gen delta_pub_icu = pub_icu_2020 / pub_icu_2019 
gen delta_priv_icu = priv_icu_2020 / priv_icu_2019
gen delta_phi_icu = phi_icu_2020 / phi_icu_2019
gen delta_nonpub_icu = (priv_icu_2020 + phi_icu_2020) / (priv_icu_2019 + phi_icu_2019)

gen hosp2019 = (pub_2019 + priv_2019 + phi_2019) / (population2019/10000)
gen hosp2020 = (pub_2020 + priv_2020 + phi_2020) / (population2020/10000)

gen delta_hosp2 = hosp2020 / hosp2019

gen icu2019_2 = (pub_icu_2019 + priv_icu_2019 + phi_icu_2019) 
gen icu2020_2 = (pub_icu_2020 + priv_icu_2020 + phi_icu_2020) 

gen delta_icu_2 = icu2020_2 / icu2019_2

gen icupc_2019 = (pub_icu_2019 + priv_icu_2019 + phi_icu_2019) / (population2019/10000)


gen delta_si  = si2021 / si2020
gen delta_lss = lss2021 / lss2020


 gen delta_gdp = ((gdp_pc2020 / gdp_pc2019) -1)
 
 
 gen delta_lss = lss2021 / lss2020
 
 
 
 * Random vars for signficance
 
/*
set seed 1

generate u1 = runiform()
*/ 


*** Table 1: Sum Stats

* Lockdown Stringency 
sum week_first_restriction2020 first_stringency_index2020 si2020 si2021 lss2020 lss2021 

* Covid variables
sum first_death2020 first_1kcases2020 first_10cases_pc2020 first_100cases_pc2020 first_1death_pc2020 first_10death_pc2020 deaths2020 cases2020

* Health Indicators
sum hospitalbeds2019 icu2019 doctors2019 health_insurance2019

* Political and Economic Variables 
sum gdp_pc2019 imlee2019 share_votes_right

* Other controls 
sum population652019 temp
 

*** Table 2: Healthcare Indicators 

eststo clear 

*---Column 1: 
eststo: reg lss2020 icu2019 hospitalbeds2019 doctors2019

*---Column 2: 
eststo: reg lss2020 icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019

*---Column 3: 
eststo: 
reg lss2020 icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp  first_death2020 population2019

test first_1death_pc2020 = icu2019 = doctors2019 = population652019 = hospitalbeds2019 = health_insurance2019 = 0
	
*---Column 4: Changes
eststo: reg lss2020 icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019 first_1death_pc2020 delta_icu delta_hosp delta_doctors

test first_1death_pc2020 = icu2019 = doctors2019 = population652019 = hospitalbeds2019 = health_insurance2019 =  delta_icu = delta_hosp = temp = delta_doctors = 0


esttab using "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Results/Table2.tex", replace star(* 0.10 ** 0.05 *** 0.01) se r2


* Table 3:  

eststo clear 

* Panel A: Votes to Right

*---Column 1: Simple
eststo: reg lss2020 share_votes_right  icu2019 hospitalbeds2019 doctors2019


*---Column 2: 
eststo: reg lss2020 share_votes_right icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019 first_1death_pc2020

test first_1death_pc2020 = icu2019 = doctors2019 = population652019 = hospitalbeds2019 = health_insurance2019 = 0

* Panel B: Reelection

*---Column 3: Simple
eststo: reg lss2020 reelection icu2019 hospitalbeds2019 doctors2019

*---Column 4: 
eststo: reg lss2020 reelection icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019 first_1death_pc2020


test first_1death_pc2020 = icu2019 = doctors2019 = population652019 = hospitalbeds2019 = health_insurance2019 = 0


* Panel C: IMLEE 

*---Column 5: Simple
eststo: reg lss2020 imlee2019 icu2019 hospitalbeds2019 doctors2019

*---Column 6: Full 
eststo: reg lss2020 imlee2019 icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019 first_1death_pc2020

test first_1death_pc2020 = icu2019 = doctors2019 = population652019 = hospitalbeds2019 = health_insurance2019 = 0are 


esttab using "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Results/Table3.tex", replace star(* 0.10 ** 0.05 *** 0.01) se r2


ttest lss2020, by(reelection)


* Table 4: Investments in Healthcare Infrastructure  

eststo clear 

*---Column 1: 
eststo: reg delta_hosp icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019

*---Column 2: 
eststo: reg delta_hosp share_votes_right imlee2019 reelection icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019


*---Column 3: 
eststo: reg delta_icu icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019

	
*---Column 4: 
eststo: reg delta_icu share_votes_right imlee2019 reelection icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019


*---Column 5: 
eststo: reg delta_doctors icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019


*---Column 6: 
eststo: reg delta_doctors share_votes_right imlee2019 reelection icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019

esttab using "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Results/Table4.tex", replace star(* 0.10 ** 0.05 *** 0.01) se r2


*** Table : Additional Results



* Robustness


* Instead of LSS, use first stringency score and raw stringency score 

eststo clear

* Panel A: Raw Stringency Index 

eststo: reg si2020 share_votes_right icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019 first_1death_pc2020

eststo: reg si2020 reelection icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019 first_1death_pc2020

eststo: reg si2020 imlee2019 icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019 first_1death_pc2020

* Panel B: First Stringency Index 

eststo: reg first_stringency_index2020 share_votes_right icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019 first_1death_pc2020

eststo: reg first_stringency_index2020 reelection icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019 first_1death_pc2020

eststo: reg first_stringency_index2020 imlee2019 icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019 first_1death_pc2020

esttab using "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Results/Table5.tex", replace star(* 0.10 ** 0.05 *** 0.01) se r2



* Use the first three months of changes in ICU to explain lockdowns in the second semester? 



* Survey data

use "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/Survey_Brazil_Covid.dta", clear

gen toomuch=0
replace toomuch = 1 if p75 ==1

gen toolittle = 0 
replace toolittle = 1 if p75 ==3


gen left = 0
replace left = 1 if p14==1 | p14==2

gen right = 0
replace right = 1 if p14==4 | p14==5


collapse (mean) left right toomuch toolittle, by(p2a)
