use "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/COVIDBR.dta", clear


foreach v in deaths2020 deaths2021 cases2020 cases2021 cases_pc2020 cases_pc2021 deaths_pc2020 deaths_pc2021 {
	
	egen m_`v' = mean(`v'), by(uf)
}
