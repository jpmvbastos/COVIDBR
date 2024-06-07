use "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/leitos_sus.dta", clear

tostring(COMP), gen(year)

replace year = substr(year,1,4)

destring year, replace

foreach v in LEITOS_EXISTENTE LEITOS_SUS UTI_TOTAL___EXIST UTI_TOTAL___SUS UTI_ADULTO___EXIST UTI_ADULTO___SUS UTI_PEDIATRICO___EXIST UTI_PEDIATRICO___SUS UTI_NEONATAL___EXIST UTI_NEONATAL___SUS UTI_QUEIMADO___EXIST UTI_QUEIMADO___SUS UTI_CORONARIANA___EXIST UTI_CORONARIANA___SUS {
	
	egen tot_`v' = total(`v'), by(UF year) 
	replace tot_`v' = tot_`v' / 12
}


collapse (mean) tot_LEITOS_EXISTENTE tot_LEITOS_SUS tot_UTI_TOTAL___EXIST tot_UTI_TOTAL___SUS tot_UTI_ADULTO___EXIST tot_UTI_ADULTO___SUS tot_UTI_PEDIATRICO___EXIST tot_UTI_PEDIATRICO___SUS tot_UTI_NEONATAL___EXIST tot_UTI_NEONATAL___SUS tot_UTI_QUEIMADO___EXIST tot_UTI_QUEIMADO___SUS tot_UTI_CORONARIANA___EXIST tot_UTI_CORONARIANA___SUS, by(UF year)

reshape wide tot_LEITOS_EXISTENTE tot_LEITOS_SUS tot_UTI_TOTAL___EXIST tot_UTI_TOTAL___SUS tot_UTI_ADULTO___EXIST tot_UTI_ADULTO___SUS tot_UTI_PEDIATRICO___EXIST tot_UTI_PEDIATRICO___SUS tot_UTI_NEONATAL___EXIST tot_UTI_NEONATAL___SUS tot_UTI_QUEIMADO___EXIST tot_UTI_QUEIMADO___SUS tot_UTI_CORONARIANA___EXIST tot_UTI_CORONARIANA___SUS, i(UF) j(year)

use "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/leitos_sus_wide.dta"

rename UF uf

merge 1:1 uf using "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/COVIDBR_19.dta"


rename tot_LEITOS_EXISTENTE2019 total_beds_2019
rename tot_LEITOS_SUS2019 beds_sus_2019
rename tot_UTI_TOTAL___EXIST2019 total_icu_2019
rename tot_UTI_TOTAL___SUS2019 icu_sus_2019
rename tot_UTI_ADULTO___EXIST2019 icu_adult_2019
rename tot_UTI_ADULTO___SUS2019  icu_adult_sus_2019
rename tot_LEITOS_EXISTENTE2020 total_beds_2020
rename tot_LEITOS_SUS2020 beds_sus_2020
rename tot_UTI_TOTAL___EXIST2020 total_icu_2020
rename tot_UTI_TOTAL___SUS2020 icu_sus_2020
rename tot_UTI_ADULTO___EXIST2020 icu_adult_2020
rename tot_UTI_ADULTO___SUS2020 icu_adult_sus_2020

foreach v in total_beds beds_sus total_icu icu_sus icu_adult icu_adult_sus {
	
	gen delta_`v' = `v'_2020 / `v'_2019
	
}


save "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/leitos_sus_wide.dta", replace
