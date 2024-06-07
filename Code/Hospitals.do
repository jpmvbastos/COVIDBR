use "/Users/jpmvbastos/Documents/GitHub/COVIDBR/Data/leitos_sus.dta"


xtset COMP CNES

encode UF, gen(uf)
encode MUNICIPIO, gen(mun)

gen covid = 0
replace covid = 1 if COMP > 202002

gen public = 0
replace public = 1 if DESC_NATUREZA_JURIDICA == "HOSPITAL_PUBLICO"


gen did = public*covid


bysort CNES (COMP): gen change = LEITOS_EXISTENTE / LEITOS_EXISTENTE[_n-1]
egen leitos_mean = mean(LEITOS_EXISTENTE) if COMP<202002, by(CNES)
egen stock = mean(leitos_mean), by(CNES)


bysort CNES (COMP): gen change_sus = LEITOS_SUS / LEITOS_SUS[_n-1]
egen leitos_sus_mean = mean(LEITOS_SUS) if COMP<202002, by(CNES)
egen stock_sus = mean(leitos_sus_mean), by(CNES)


