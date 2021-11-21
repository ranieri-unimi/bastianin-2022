import delimited "\\wsl.localhost\bastianin\home\tosho\bastianin-2022\datasets-clean\xxx-final-dataset.csv"

gen satias = (2*z_4 + house_midterm -1)*incumbent/2
*gen satias = (2*z_mt_2 + house_midterm -1)*incumbent/2

* fair
replace fair_p_1 = fair_p_1*incumbent
replace fair_g_1 = fair_g_1*incumbent

* z and inc same

* yeet2year
forvalues j = 1/4 {
*replace def_`j'= def_`j'*incumbent
*replace gdp_`j' = gdp_`j'*incumbent
replace z_`j'= z_`j'*incumbent

*replace avg_inc_`j'= avg_inc_`j'*incumbent
*replace unemp_`j' = unemp_`j'*incumbent
}

* meed2mid
forvalues j = 1/2 {
replace def_mt_`j'= def_`j'*incumbent
replace gdp_mt_`j' = gdp_mt_`j'*incumbent
*replace z_mt_`j'= z_mt_`j'*incumbent

replace avg_mt_inc_`j'= avg_mt_inc_`j'*incumbent
replace unemp_mt_`j' = unemp_mt_`j'*incumbent
}

gen z_0 = z_1 + z_2 + z_3 + z_4

encode state, gen(tmp)
drop state
rename tmp state
xtset state year, delta(4)

* solo FAIR
xtreg y_votes_percent fair_g_1 fair_p_1 z_4-z_1 incumbent-former_party_morethan_2, fe vce(cluster state)

* OUR reg
xtreg y_votes_percent fair_p_1-satias, fe vce(cluster state)

* NO ECN
xtreg y_votes_percent incumbent-house_midterm satias, fe vce(cluster state)






est store FEstata
testparm i.state 
testparm i.year

* fe dummy
reg y_votes_percent def_4-unemp_1 i.state
est store FEdummies

* Test if entity FE are significantly different from zero
testparm i.state 
testparm i.year


estimates table FE*, star(.05)  varlabel