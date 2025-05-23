import delimited "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/COVIDBR.csv", clear 

label var uf "State Abbrevation"
label var code "State code (IBGE)"
label var state "State name" 
label var stategdp "State GDP (in 2010 BRL), IPEADATA"
label var population "Total population, IPEADATA"
label var health_insurance "% of pop. with health insurance, IPEADATA"
label var hospitalbeds "Hospital beds per 10,000 people, OpenDataSUS"
label var icu "ICU beds per 10,000 people, OpenDataSUS"
label var population65 "% of population > 65yo, IPEADATA "
label var doctors  "Doctors per 10,000 people, OpenDataSUS"
label var gdp_pc "GDP per capita (in 2010 BRL), IPEADATA"
label var imlee "State Economic Freedom Score, Mackenzie Center"
label var lss "Lockdown Severity Score, Miozzi & Powell (2023)"
label var first_restriction "Date of first mandated restriction, OxCGRT"
label var first_stringency_index "Stringency at date of 1st mandated restriction, OxCGRT"
label var week_first_restriction "Week of first mandated restriction, OxCGRT"
label var deaths_week13 "Cum. Deaths at week 13, OpenDataSUS"
label var cases_week13 "Cum. Cases at week 13, OpenDataSUS"
label var first_death "Week of first death (=12 if before week 13), OpenDataSUS"
label var first_1kcases "Week reached 1,000 cum. cases, OpenDataSUS"
label var first_10cases_pc "Week reached 10 cases per 100k, OpenDataSUS"
label var first_100cases_pc "Week reached 100 cases per 100k, OpenDataSUS"
label var first_1death_pc "Week reached 1 death per 100k, OpenDataSUS"
label var first_10death_pc "Week reached 10 deaths per 100k, OpenDataSUS"
label var si2020 "Mean Stringency index score (2020), OxCGRT"
label var si2021 "Mean Stringency index score (2021), OxCGRT"
label var votes_left "Number of votes for Fernando Haddad (left)"
label var votes_right "Number of votes for Jair Bolsonaro (right)"
label var votes_null "Number of null votes (votos brancos e nulos)"
label var share_votes_right "Share of votes for Jair Bolsonaro"
label var deaths2020 "Total deaths (2020), OpenDataSUS"
label var deaths2021 "Total deaths (2021), OpenDataSUS"
label var cases2020 "Total cases (2020), Open Data SUS"
label var cases2021 "Total cases (2021), OpenDataSUS"
label var cases_pc2020 "Total cases per 100k (2020), OpenDataSUS"
label var cases_pc2021 "Total cases per 100k (2021), OpenDataSUS"
label var deaths_pc2020 "Total deaths per 100k (2020), OpenDataSUS"
label var deaths_pc2021 "Total deaths per 100k (2021), OpenDataSUS"

save "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/COVIDBR.dta", replace


use "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/COVIDBR.dta", clear


drop lss2019 deaths_week132019 cases_week132019 first_death2019 first_1kcases2019 first_10cases_pc2019 first_100cases_pc2019 first_1death_pc2019 first_10death_pc2019 si20202019 si20212019 deaths20202019 deaths20212019 cases20202019 cases20212019 cases_pc20202019 cases_pc20212019 deaths_pc20202019 deaths_pc20212019 si20212020 si20202021 votes_left2019 votes_right2019 votes_null2019 share_votes_right2019 votes_left votes_right2020 votes_null2020 votes_left2021 votes_right2021 votes_null2021 share_votes_right2021 si20202021 deaths20202021 cases20202021 cases_pc20202021 deaths_pc20202021 deaths20212020 cases20212020 cases_pc20212020 deaths_pc20212020 first_restriction2019 first_stringency_index2019 week_first_restriction2019
 
rename share_votes_right2020 share_votes_right
rename si20212021 si2021
rename deaths20212021 deaths2021
rename cases20212021 cases2021 
rename cases_pc20212021 cases_pc2021 
rename deaths_pc20212021 deaths_pc2021
rename si20202020 si2020
rename deaths20202020 deaths2020
rename cases20202020 cases2020 
rename cases_pc20202020 cases_pc2020 
rename deaths_pc20202020 deaths_pc2020

save "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/COVIDBR_Final.dta", replace

use "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/COVIDBR_Final.dta", clear

merge 1:1 uf using "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/extra.dta"

drop _merge


/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/Brazil Monthly LRF.xlsx

merge 1:1 uf using "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/governors.dta"

drop _merge

* Monthly data for simultaneity robustness check 

merge 1:1 uf using "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/MonthlyLRF.dta"

save "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/COVIDBR_Final.dta", replace

* data for distrito federal is missing from the table
replace LRFAugDec2020 = 6.03 if uf=="DF"

drop _merge

merge 1:1 uf using "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/first_semester_cases.dta"

save "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/COVIDBR_Final.dta", replace


* google trends data

import excel "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/google-trends.xlsx", firstrow sheet("Sheet1") clear

save "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/google-trends.dta", replace

* federal transfers data

import excel "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/federal-transfers.xlsx", firstrow sheet("Sheet1") clear

drop if _n>27

save "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/federal-transfers.dta", replace



* merge

use "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/COVIDBR_Final.dta", clear

merge 1:1 uf using "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/google-trends.dta"

drop _merge

merge 1:1 uf using "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/federal-transfers.dta"
