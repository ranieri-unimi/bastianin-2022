import delimited "\\wsl.localhost\bastianin\home\tosho\bastianin-2022\datasets-clean\xxx-final-dataset.csv"

encode state, gen(tmp)
drop state
rename tmp state
xtset state year, delta(4)

gen g_4 =  gdp_4*incumbent
gen g_3 = gdp_3*incumbent
gen g_2 = gdp_2*incumbent
gen g_1 = gdp_1*incumbent
gen d_4 = def_4*incumbent
gen d_3 = def_3*incumbent
gen d_2 = def_2*incumbent
gen d_1 = def_1*incumbent
gen zz_4 = z_4*incumbent
gen zz_3 = z_3*incumbent
gen zz_2 = z_2*incumbent
gen zz_1 = z_1*incumbent

xtreg y_votes_percent def_4-unemp_1, fe

gen def_4-unemp_1*incumbent

forvalues j = 1/4 {
replace def_`j'= def_`j'*incumbent
replace z_`j'= z_`j'*incumbent
replace gdp_`j'= gdp_`j'*incumbent
replace unemp_`j'= unemp_`j'*incumbent
replace avg_inc_`j'= avg_inc_`j'*incumbent

}