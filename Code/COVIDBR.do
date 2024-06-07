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




* Create the change in beds per 10,000 people



* Table 1: Sum Stats

sum 


* Table : 

eststo clear 

*---Column 1: Simple
*eststo: 
reg lss2020 icu2019 hospitalbeds2019 doctors2019

*---Column 2: 
*eststo: 
reg lss2020 icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019

*---Column 3: 
*eststo: 
reg lss2020 icu2019 doctors2019 population652019 hospitalbeds2019 health_insurance2019 temp first_1death_pc2020 gdp_pc2019
	
*---Column 4: 
*eststo: 
reg lss2020 icu2019 doctors2019 population652019 hospitalbeds2019 health_insurance2019 temp first_1death_pc2020 gdp_pc2019

test first_1death_pc2020 = icu2019 = doctors2019 = population652019 = hospitalbeds2019 = health_insurance2019 = 0

esttab using "`path'/Results/Table4.tex", replace star(* 0.10 ** 0.05 *** 0.01) se r2


* Table : 

eststo clear 

* Panel A: Votes to Right

*---Column 1: Simple
*eststo: 
reg lss2020 share_votes_right  icu2019 hospitalbeds2019 doctors2019

*---Column 2: 
*eststo: 
reg lss2020 share_votes_right  icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019

*---Column 3: 
*eststo: 
reg lss2020 share_votes_right icu2019 doctors2019 population652019 hospitalbeds2019 health_insurance2019 temp first_1death_pc2020 gdp_pc2019


* Panel B: IMLEE 

*---Column 1: Simple
*eststo: 
reg lss2020 imlee2019 icu2019 hospitalbeds2019 doctors2019

*---Column 2: 
*eststo: 
reg lss2020 imlee2019 icu2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019

*---Column 3: 
*eststo: 
reg lss2020 imlee2019 icu2019 doctors2019 population652019 hospitalbeds2019 health_insurance2019 temp first_1death_pc2020 gdp_pc2019


test first_1death_pc2020 = icu2019 = doctors2019 = population652019 = hospitalbeds2019 = health_insurance2019 = 0

*esttab using "`path'/Results/Table4.tex", replace star(* 0.10 ** 0.05 *** 0.01) se r2



* Table : 

eststo clear 

*---Column 1: Simple
*eststo: 
reg delta_icu_2 icupc_2019 hospitalbeds2019 doctors2019 

*---Column 2: 
*eststo: 
reg delta_icu_2 icupc_2019 hospitalbeds2019 doctors2019 health_insurance2019 population652019 temp gdp_pc2019

*---Column 3: 
*eststo: 
reg delta_icu_2 icupc_2019 doctors2019 population652019 hospitalbeds2019 health_insurance2019 temp first_1death_pc2020 gdp_pc2019
	
*---Column 4: 
*eststo: 
reg delta_icu_2 share_votes_right imlee2019 icupc_2019 doctors2019 population652019 hospitalbeds2019 health_insurance2019 temp first_1death_pc2020 gdp_pc2019


test first_1death_pc2020 = icu2019 = doctors2019 = population652019 = hospitalbeds2019 = health_insurance2019 = 0

esttab using "`path'/Results/Table4.tex", replace star(* 0.10 ** 0.05 *** 0.01) se r2




* Robustness

reg lss2020 share_votes_right first_10cases_pc2020 icu2019 doctors2019 population652019 hospitalbeds2019 health_insurance2019 gdp_pc2019 temp






